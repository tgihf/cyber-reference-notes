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
- Potential `$WORDLIST` options:
	- [`/usr/share/wordlists/seclists/Discovery/Web-Content/raft-small-words.txt`](https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-small-words.txt)
	- `/usr/share/wordlists/dirbuster/directory-list-1.0.txt`
		- Has small, medium, large, & lowercase variants
	- `/usr/share/wordlists/dirb/common.txt`
	- `/usr/share/wordlists/dirb/big.txt`

---

## Brute force a web application to discover virtual hosts

```bash
gobuster vhost -u $URL -w $WORDLIST
```

- Potential `$WORDLIST` options:
	- [`/usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt`](https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-5000.txt)
	- [`/usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-20000.txt`](https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-20000.txt)
	- [`/usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-110000.txt`](https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-110000.txt)
