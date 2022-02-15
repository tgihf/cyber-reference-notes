# Web Application Virtual Host Discovery

> A web application virtual host is an application-level routing feature in which a web server routes requests to different web applications based on the HTTP `HOST` header. For example, though the static website (`www.tgihf.click`) and API (`api.tgihf.click`) are running on the same server, Apache routes requests to the proper one based on the HTTP `HOST` header value.

---

## Tools

- [[gobuster#Brute force a web application to discover virtual hosts|gobuster]]
- [[wfuzz]]

---

## Useful Wordlists

- `/usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-5000.txt`
- `/usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-20000.txt`
- `/usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-110000.txt`

---

## References

[SecLists](https://github.com/danielmiessler/SecLists)
