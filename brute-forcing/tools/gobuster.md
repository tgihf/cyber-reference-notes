# gobuster - multi-threaded web application fuzzer written in Go

---

## Brute force a web application to discover content

```bash
gobuster dir -u $URL -w $WORDLIST [-x $FILE_EXTENSIONS] [-b $STATUS_CODES_TO_IGNORE] [--exclude-lengths $RESPONSE_SIZES_TO_IGNORE]
```

- `$FILE_EXTENSIONS`
	- i.e., `php,txt,html`
- `$STATUS_CODES_TO_IGNORE`
	- Defaults to `404`
	- i.e., `404,403`
- `$RESPONSE_SIZES_TO_IGNORE`
	- i.e., `275,4000`
- Potential `$WORDLIST` options can be found [[content-discovery#Useful Wordlists|here]]

---

## Brute force a web application to discover virtual hosts

```bash
gobuster vhost -u $URL -w $WORDLIST
```

- Potential `$WORDLIST` options can be found [[virtual-host-discovery#Useful Wordlists|here]]