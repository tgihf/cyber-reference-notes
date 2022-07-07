# [feroxbuster](https://github.com/epi052/feroxbuster)

> Web application path discovery tool written in Rust.

---

## Documentation Site

See [here](https://epi052.github.io/feroxbuster-docs/docs/).

---

## Configuration File

`ferox-config.toml` in `/etc/feroxbuster/` on Kali or in the same directory as the `ferboxbuster` binary.

---

## Discover Content

```bash
feroxbuster -u $URL [-w $WORDLIST] [-x $FILE_EXTENSIONS] [--filter-status $STATUS_CODES_TO_IGNORE] [--filter-size $RESPONSE_SIZES_TO_IGNORE] [--filter-similar-to $URL_OF_SIMILAR_PAGE] [--json --output $OUTPUT_FILE]
```

- Potential `$WORDLIST` options can be found [[path-discovery#Useful Wordlists|here]]
	- Defaults to `wordlist` option in `ferox-config.toml` (in `/etc/feroxbuster` on Kali)
- `$FILE_EXTENSIONS`
	- i.e., `php,txt,html`
- `$STATUS_CODES_TO_IGNORE`
	- Defaults to `404`
	- i.e., `404,403`
- `$RESPONSE_SIZES_TO_IGNORE`
	- i.e., `275,4000`
- `$URL_OF_SIMILAR_PAGE`: filter pages that are similar to the one at this URL
	- i.e., `http://foo/bar`
- `$OUTPUT_FILE`: JSON output file

### Example Run

This scan recursively ran `/usr/share/seclists/Discovery/Web-Content-raft-medium-directories.txt` to a depth of 4 against `http://horizontall.htb` and found `/js`, `/img`, and `/css`.

```bash
$ feroxbuster -u http://horizontall.htb --json --output blah.json

 ___  ___  __   __     __      __         __   ___
|__  |__  |__) |__) | /  `    /  \ \_/ | |  \ |__
|    |___ |  \ |  \ | \__,    \__/ / \ | |__/ |___
by Ben "epi" Risher 🤓                 ver: 2.5.0
───────────────────────────┬──────────────────────
 🎯  Target Url            │ http://horizontall.htb
 🚀  Threads               │ 50
 📖  Wordlist              │ /usr/share/seclists/Discovery/Web-Content/raft-medium-directories.txt
 👌  Status Codes          │ [200, 204, 301, 302, 307, 308, 401, 403, 405, 500]
 💥  Timeout (secs)        │ 7
 🦡  User-Agent            │ feroxbuster/2.5.0
 💉  Config File           │ /etc/feroxbuster/ferox-config.toml
 🧔  JSON Output           │ true
 💾  Output File           │ blah.json
 🏁  HTTP methods          │ [GET]
 🔃  Recursion Depth       │ 4
───────────────────────────┴──────────────────────
 🏁  Press [ENTER] to use the Scan Management Menu™
──────────────────────────────────────────────────
301      GET        7l       13w      194c http://horizontall.htb/js => http://horizontall.htb/js/
301      GET        7l       13w      194c http://horizontall.htb/img => http://horizontall.htb/img/
301      GET        7l       13w      194c http://horizontall.htb/css => http://horizontall.htb/css/
[####################] - 30s   119996/119996  0s      found:3       errors:0
[####################] - 29s    29999/29999   1004/s  http://horizontall.htb
[####################] - 29s    29999/29999   1005/s  http://horizontall.htb/js
[####################] - 29s    29999/29999   1005/s  http://horizontall.htb/img
[####################] - 29s    29999/29999   1005/s  http://horizontall.htb/css
```
