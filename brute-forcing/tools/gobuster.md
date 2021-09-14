# gobuster - multi-threaded web application fuzzer written in Go



## Brute force web server to discover content

```bash
gobuster dir -u $URL -w $WORDLIST [-x $FILE_EXTENSIONS] # $FILE_EXTENSIONS -> php,txt,html
```

* Potential word lists:
	* [`/usr/share/wordlists/Seclists/Discovery/Web-Content/raft-small-words.txt`](https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/raft-small-words.txt)
	* `/usr/share/wordlists/dirb/common.txt`
	* `/usr/share/wordlists/dirb/big.txt`