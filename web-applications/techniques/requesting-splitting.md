# Request Splitting

> An attack that abuses the flexibility and discrepencies in the parsing and interpretation of HTTP request messages by different intermediary HTTP agents (e.g., HTTP libraries, load balancers, reverse proxies, web caching proxies, application firewalls, etc.) to split a single HTTP request into multiple unauthorized and malicious HTTP requests to a backend HTTP agent (e.g., web application).

---

## Node.js <= 8 HTTP Library Vulnerability

Node.js version 8 and below's [http.get()](https://nodejs.org/api/http.html#httpgeturl-options-callback) function validates user input as Unicode strings but writes the validated input to the wire in the `latin1` character set. This results in a loss of bytes that makes it possible to perform a request splitting attack. See the following for details.

- [HackerOne Bug Report](https://hackerone.com/reports/409943)
- [This Detailed Report](https://www.rfk.id.au/blog/entry/security-bugs-ssrf-via-request-splitting/)
- [Hack the Box's Weather App Web Challenge](https://github.com/tgihf/private-writeups/blob/main/htb/challenges/weather-app/weather-app.md)

---

## References

[White Hat Security - HTTP Requeset Splitting](https://www.whitehatsec.com/glossary/content/http-request-splitting#:~:text=What%20is%20HTTP%20Request%20Splitting,and%20poisoning%20the%20browser's%20cache.)

[MITRE - CAPEC-105: HTTP Request Splitting](https://capec.mitre.org/data/definitions/105.html)
