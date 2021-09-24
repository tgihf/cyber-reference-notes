# [Dynamic DNS](https://en.wikipedia.org/wiki/Dynamic_DNS)

> A protocol for automatically DNS entries whenever a host's IP address changes.

---

## Common Use Case

You want a server in your internal network to be accessible via the Internet. Your router leverages NAT and your ISP constantly changes your router's external IP address.

You can run a dynamic DNS client in your internal network to continually inform (generally via an API) a dynamic DNS server of your router's external IP address and the server will make sure that the IP address is always associated with the given hostname in the upstream DNS servers.

---

## Popular Dynamic DNS Services

- [no-ip](https://www.noip.com/)
	- [no-ip Client Docker Image](https://hub.docker.com/r/coppit/no-ip)
- [Duck DNS](https://www.duckdns.org/)
	- [Duck DNS Client Docker Image](https://hub.docker.com/r/linuxserver/duckdns/)