# [/etc/passwd](https://www.cyberciti.biz/faq/understanding-etcpasswd-file-format/)

> `/etc/passwd` is a Unix file that contains user account information.

---

## Structure

Each line corresponds to a different user. Within each line, each piece of user account data is delimited by a `:` with the following structure:

```txt
$USERNAME:$PASSWORD:$USER_ID:$GROUP_ID:$COMMENT:$HOME_DIRECTORY:$DEFAULT_SHELL
```

- `$PASSWORD`:
	- `x` indicates the password hash is stored in [[etc-shadow|/etc/shadow]]
