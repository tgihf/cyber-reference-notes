# Server Side Request Forgery (SSRF)

> A vulnerability in which an attacker induces a web application into making a network request (over any protocol) to a URL of the attacker's choosing. This vulnerability is often exploited to interact with the server's `localhost` interface, other backend systems typically only routable from the server itself, external systems for the purpose of action forgery, or attacker-controlled systems for the purpose of leaking sensitive information (i.e., cookies).

---

## SSRF Methodology

1. Locate the vulnerability
	- Are there any inputs that directly take a URL? What does the application do with the URL? Does it make a request to it? Does it render the response?
	- Are there any inputs that appear to be used in the construction of a URL that the backend makes a request to? Does it render the response?
	- Are there any [[file-uploads|file upload]] inputs that parse XML files? Is the XML parser vulnerable to [[xxe|XXE]], which could also lead to SSRF?
	- What happens if you include the URL of an attacker controlled system in headers that are commonly visited by analytic engines, such as `X-Forwarded-For`, `True-Client-IP`, `Referer`, and `X-WAP-Profile`? Do they result in SSRF requests to the attacker controlled system?
2. With a vulnerability located, how can you exploit it? What systems can you induce the web server to interact with?
	- [[#SSRF to Interact with the Server's localhost Interface|The web application itself (localhost interface)]]
	- [[server-side-request-forgery#SSRF to Interact with Non-Routable Backend Systems|Non-routable backend systems]]
	- [[server-side-request-forgery#SSRF to Interact with Attacker-Controlled System|Attacker-controlled system]]
3. Are there SSRF defenses in play?
	- [[#Bypassing an SSRF Blacklist|Bypassing a blacklist]]
	- [[#Bypassing an SSRF Whitelist|Bypassing a whitelist]]
	- [[#Bypassing SSRF Filtering via Open Redirection|Bypassing filter via open redirect]]
	- [[server-side-request-forgery#Bypassing SSRF Filtering via Attacker Redirection|Bypassing filter via attacker-controlled redirect]]
	- What protocols are allowed?
		- i.e., `http://`, `https://`, `file://`, `dict://`, `ftp://`, `ldap://`, `gopher://`

---

## SSRF to Interact with the Server's `localhost` Interface

An SSRF vulnerability may make it possible to interact with a web application's `localhost` interface, and doing so opens up some exciting possibilities:

- The web application's access control mechanism may be enforced by another component that sits in front of the web application. By interacting with the web application over `localhost`, you would bypass that mechanism.
- The web application may be configured to implicitly trust requests from `localhost`.
- Other services may be listening on the application's `localhost` interface (i.e., APIs, databases).

An attacker can exploit an SSRF vulnerability in order to interact with the server's `localhost` interface by directing it to one of the following addresses/hostnames:

- `127.0.0.1`
- `127.1`
- `localhost`
- `::1`
- `2130706433` (the decimal equivalent of `127.0.0.1`)
- An external domain name that you control that points to `127.0.0.1` (i.e., `lh.tgihf.click` -> `127.0.0.1`)
- `spoofed.burpcollaborator.net`, which points to `127.0.0.1`
- The web application's FQDN (i.e, `www.tgihf.click`)

---

## SSRF to Interact with Non-Routable Backend Systems

An SSRF vulnerability may make it possible to interact with other backend systems that aren't routable from users but are routable from the web application server itself. Many of these systems provide services to support the web application (i.e., APIs, databases) and since they aren't publicly routable, they are often implemented without requiring authentication at all or they implicitly trust the web application server.

For example, say the web application has a private network interface card attached to the `192.168.20.0/24` network. An attacker could exploit an SSRF vulnerability in the web application to [scan](https://cobalt.io/blog/from-ssrf-to-port-scanner) that network and send specially crafted requests to the hosts on that network.

---

## SSRF to Interact with Attacker-Controlled System

Depending on the environment, an SSRF vulnerability may make it possible to have the web application send a request to an attacker-controlled system. This is primarily useful for the purpose of **capturing cookies**.

---

## Bypassing an SSRF Blacklist

A web application may reject an input URL that **exactly matches**, **begins with**, or **contains** a blacklist of forbidden values, such as `127.0.0.1` and `localhost`.

Interact with the vulnerability and attempt to understand that blacklisting logic. Some things to try:

- `localhost`-specific alternatives can be found [[#SSRF to Interact with the Server's localhost Interface|here]]
- The decimal equivalent of the IPv4 address
- IPv6 address
- An external domain name that you control that points to the target address
- Vary the case of the URL's domain name
- URL-encode or double URL-encode particular characters in the URL's domain name

You also may be able to bypass the blacklist via an [[#Bypassing SSRF Filtering via Open Redirection|open redirect]] or an [[#Bypassing SSRF Filtering via Attacker Redirection|attacker redirect]].

---

## Bypassing an SSRF Whitelist

A web application may only allow an input URL that **exactly matches**, **begins with**, or **contains** a whitelist of permitted values.

In this situation, you may be able to bypass the whitelisting logic by exploiting inconsistencies in URL parsing. The URL specification contains several features that a developer may have overlooked while implementing ad hoc URL parsing and validation:

- You can embed credentials in a URL before the hostname using the following syntax: `$PROTOCOL://[$USERNAME[:$PASSWORD]]@$HOSTNAME`
	- i.e., `https://whitelisted-host@evil-host`
- You can use embed a URL fragment using the following syntax: `$PROTOCOL://$HOSTNAME#$FRAGMENT`
	- i.e., `https://evil-host.com#whitelisted-host`
- You can leverage the DNS naming hierarchy to place required input into a FQDN that you control
	- i.e., `https://whitelisted-host.evil-host`
- You can URL-encode characters to confuse the URL parsing code
	- This is particularly useful if the code that implements the filter handles URL-encoded characters differently than the code that performs the backend SSRF request
- You can combine these techniques together

You also may be able to bypass tricking the URL parsing logic entirely via an [[#Bypassing SSRF Filtering via Open Redirection|open redirect]] or an [[#Bypassing SSRF Filtering via Attacker Redirection|attacker redirect]].

---

## Bypassing SSRF Filtering via Open Redirection

If the web application only allows the input URL to be on a domain that has an existing [[open-redirect|open redirect]] vulnerability, you could exploit that vulnerability to have the web application redirect to an arbitrary URL.

For example, say the web application has an SSRF vulnerability but only allows requests to itself, `https://www.tgihf.click`. This same web application has an [[open-redirect|open redirect]] vulnerability at `https://www.tgihf.click/success?next=$URL`. By inputting the URL `https://www.tgihf.click/success?next=https://localhost/admin`, you could access `https://localhost/admin`.

---

## Bypassing SSRF Filtering via Attacker Redirection

If the web application allows the input URL to be on a domain that you have control over and the backend library used to make the request follows redirects, you could host a redirect to the target URL. When the SSRF is triggered and the web application visits your URL, you will redirect them to the target URL.

For example, let's say you own `www.tgihf.click` and the target web application has an SSRF vulnerability that allows requests to `www.tgihf.click`. You want to access an admin panel on the target web server's `https://localhost/admin`.

You first craft the redirect response and host it, like so:

```bash
$ cat redirect.txt
HTTP/1.1 301 MOVED PERMANENTLY
Location: https://localhost/admin

$ nc -nlvp 80 < redirect.txt
```

Then you exploit the SSRF vulnerability, inducing the web application to make a request to the redirect you're hosting on `http://www.tgihf.click`. They'll be redirected to `https://localhost/admin`.

---

## References

[PortSwigger Web Security Academy - Server Side Request Forgery](https://portswigger.net/web-security/ssrf)

[PortSwigger Web Security Academy - Blind Server Side Request Forgery](https://portswigger.net/web-security/ssrf/blind)

[YouTube - Orange Tsai - A New Era of SSRF - Exploiting URL Parsers](https://www.youtube.com/watch?v=D1S-G8rJrEk)
