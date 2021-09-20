# gobuster - multi-threaded web application fuzzer written in Go

---

## Brute force a web application to discover content

```bash
gobuster dir -u $URL -w $WORDLIST [-x $FILE_EXTENSIONS] # $FILE_EXTENSIONS -> php,txt,html
```

* Potential word lists:
	* [`/usr/share/wordlists/Seclists/Discovery/Web-Content/raft-small-words.txt`](https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-small-words.txt)
	* `/usr/share/wordlists/dirb/common.txt`
	* `/usr/share/wordlists/dirb/big.txt`

---

## Brute force a web application to discover virtual hosts

```bash
gobuster vhost -u $URL -w $WORDLIST
```

- Potential word lists:
	- [`/usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-5000.txt`](https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-5000.txt)
	- [`/usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-20000.txt`](https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-20000.txt)
	- [`/usr/share/wordlists/SecLists/Discovery/DNS/subdomains-top1million-110000.txt`](https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-110000.txt)
