# Server Side Request Forgery (SSRF)

> A vulnerability in which an attacker induces a web application into making a network request (over any protocol) to a URL of the attacker's choosing. This vulnerability is often exploited to interact with the server's `localhost` interface, other backend systems typically only routable from the server itself, external systems for the purpose of action forgery, or attacker-controlled systems for the purpose of leaking sensitive information (i.e., cookies).

---

## SSRF Methodology

Exactly how to exploit an SSRF vulnerability depends significantly on the web application itself and the objective of the assessment. As such, a one-size-fits-all methodology isn't going to be helpful. Instead, here's some things to keep in mind:

- Potential URLs to induce the web application to interact with:
	- [[#SSRF to Interact with the Server's localhost Interface|The web application itself (localhost interface)]]
	- [[server-side-request-forgery#SSRF to Interact with Non-Routable Backend Systems|Non-routable backend systems]]
	- [[server-side-request-forgery#SSRF to Interact with Attacker-Controlled System|Attacker-controlled system]]
- SSRF filtering considerations:
	- 

---

## SSRF to Interact with the Server's `localhost` Interface

SSRF makes it possible to interact with a web application's `localhost` interface, and doing so opens up some exciting possibilities:

- The web application's access control may be enforced by another component that sits in front of the web application. By interacting with the web application over `localhost`, you bypass that mechanism.
- The web application may be configured to implicitly trust requests from `localhost`.
- Other services may be listening on the application's `localhost` interface (i.e., APIs, databases).

An attacker can exploit an SSRF vulnerability in order to interact with the server's `localhost` interface by directing it to one of the following addresses/hostnames:

- `127.0.0.1`
- `localhost`
- `::1`
- `2130706433` (the decimal equivalent of `127.0.0.1`)

---

## SSRF to Interact with Non-Routable Backend Systems

SSRF makes it possible to interact with other backend systems that aren't routable from users but are routable from the web application server itself. Many of these systems provide services to support the web application (i.e., APIs, databases) and since they aren't publicly routable, they are often implemented without requiring authentication at all or they implicitly trust the web application server.

---

## SSRF to Interact with Attacker-Controlled System

Depending on the environment, an SSRF vulnerability may make it possible to have the web application send a request to an attacker-controlled system. This is primarily useful for the purpose of **capturing cookies**.
