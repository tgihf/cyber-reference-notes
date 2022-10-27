# Redirectors

> Cheap and quick and easy to deploy, redirectors protect the C2 server by proxying traffic between it and compromised targets.

---

## Types of Redirectors

1. [[redirectors#Dumb Redirector Techniques|Dumb redirectors]] redirect *all traffic* to the C2 server and vice versa
	- Quick and easy to set up, but leave your C2 server exposed if defenders decide to interact with the redirector
2. [[redirectors#Smart Redirector Techniques|Smart redirectors]] redirect *legitimate C2 traffic* to the C2 server and vice versa, redirecting all other traffic to a real domain
	- More time-consuming to set up, but more effectively protects your C2 server if defenders decide to interact with the redirector

---

## Dumb Redirector Techniques

### TCP Redirection

- [[socat#TCP Redirection|socat]]
- [[iptables#TCP Redirection|iptables]]
- [[tunneling-with-openssh-client#Local Port Forwarding|Local port forward via SSH]]
- [[tunneling-with-openssh-client#Remote Port Forwarding|Remote port forward via SSH]]


### UDP Redirection

- [[socat#UDP Redirection|socat]]
- [[iptables#UDP Redirection|iptables]]

---

## Smart Redirector Techniques

- [Apache mod_rewrite](https://github.com/bluscreenofjeff/Red-Team-Infrastructure-Wiki#other-apache-mod_rewrite-resources)
- [Nginx proxy_pass](https://coffeegist.com/security/resilient-red-team-https-redirection-using-nginx/)
- [Domain Fronting](https://github.com/bluscreenofjeff/Red-Team-Infrastructure-Wiki#domain-fronting)

---

## Redirector Hardening

See [[iptables#Redirector Hardening|iptables]].