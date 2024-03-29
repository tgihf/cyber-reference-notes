# Web Application Path Discovery

> Web applications host various resources at various **paths** and these paths aren't always linked to by other parts of the web application. Thus, you won't always find all of a web application's paths by browsing around it, clicking links. Various tools and wordlists exists to help you discover these paths. Many of these paths leverage **methods** and **query parameters** which aren't immediately apparent as well. These same tools and some different wordlists can help you discover these methods and parameters.

---

## Tools

- [[feroxbuster#Discover Content|feroxbuster]]
- [[gobuster#Brute force a web application to discover content|gobuster]]
- [[wfuzz]]
- [[patator]]

---

## Useful Wordlists

- `/usr/share/wordlists/seclists/Discovery/Web-Content/raft-small-words.txt`
	- Has `small`, `medium`, and `large` variants
	- Has `words` and `directories` variants
	- Has `lowercase` variant
- `/usr/share/wordlists/dirbuster/directory-list-1.0.txt`
	- Has small, medium, large, & lowercase variants
- `/usr/share/wordlists/dirb/common.txt`
- `/usr/share/wordlists/dirb/big.txt`

---

## References

[SecLists](https://github.com/danielmiessler/SecLists)
