# Website Research

---

## Website Research Process

1. Given a domain, [[website-research#Find a Domain's Subdomains|find all the domain's subdomains]].
2. For each of the subdomains, [[website-research#Check to See if a Website is Live|check to see if it is alive]].
3. (Optional) [[website-research#Take Screenshots of a List of Websites|Automatically take screenshots of all the live subdomains]]
4. For each live subdomain:
	- Get its [[website-research#Enumerate a Domain's Information|WHOIS information]]
	- Get its [[website-research#Determine a Website's Technologies|technology stack]]
	- Maybe [[website-research#Find a Website from a Different Point in Time|see what it looked like at another point in time]]
	- Get its [[website-research#View a Website's Backlinks|backlinks]]

---

## Find a Domain's Subdomains

### Command Line Tools

- [[amass#Find a Domain's Subdomains|amass]]
- [[assetfinder#Find a Domain's Subdomains|assetfinder]]
- [[subfinder#Find a Domain's Subdomains|subfinder]]

### Web Applications

- [crt.sh](https://crt.sh/)
	- Example wildcarded input: `%.tgihif.click`
- [Pentest Tools - Find Subdomains](https://pentest-tools.com/information-gathering/find-subdomains-of-domain)
- [Spyse Subdomain Finder](https://spyse.com/tools/subdomain-finder)
- [[search-engines#site|Most search engines' site operator]] can be used to find subdomains

---

## Check to See if a Website is Live

- [[httprobe#Check to See if a Website is Live|httprobe]]

---

## Take Screenshots of a List of Websites

- [[gowitness#Take Screenshots of a List of URLs|gowitness]]

---

## Enumerate a Domain's Information

Including IP address, WHOIS record, DNS records, hosting provider, registrars, registrant information, passive service scanning, and more.

### Command Line

```bash
whois $DOMAIN
```

### Web Applications

- [Centrol Ops's Domain Dossier](https://centralops.net/co/)
- [Spy On Web](https://spyonweb.com)
- [View DNS Info](https://viewdns.info)

---

## Determine a Website's Technologies

### Browser Extensions

- [Wappalyzer](https://github.com/twintproject/twint)

### Web Applications

- [builtwith.com](https://builtwith.com/)

---

## Find a Website from a Different Point in Time

- [Wayback Archive](http://web.archive.org/)

---

## View a Website's Backlinks

A website's backlink is a link on a different website that points to it.

- [Backlink Watch](https://backlinkwatch.com)
