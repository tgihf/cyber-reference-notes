# [python3 smtpd](https://docs.python.org/3/library/smtpd.html)

> Python module that offers several classes to implement SMTP (email) servers.

## Stand up simple SMTP server

```bash
sudo python3 -m smtpd -n -c DebuggingServer $LISTEN_IP:$LISTEN_PORT
```