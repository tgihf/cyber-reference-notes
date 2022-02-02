# Phishing Infrastructure

---

## Phishing Infrastructure Setup Process

1. Use a single Debian-flavored Linux virtual private server (i.e., [AWS EC2 instance](https://aws.amazon.com/ec2/), [Digital Ocean droplet](https://www.digitalocean.com/products/droplets), [Azure virtual machine](https://azure.microsoft.com/en-us/services/virtual-machines/)) that will host:
	- The [[gophish]] server
	- The [[evilginx2]] proxy
2. Set the following firewall rules (i.e., EC2's Security Group rules):
	- Allow TCP 22 (SSH) inbound
	- Allow TCP/UDP 53 (DNS) inbound
	- Allow TCP 80 (HTTP) inbound
	- Allow TCP 443 (HTTPS) inbound
	- Allow TCP 3333 ([[gophish]] admin interface) inbound
	- Deny all else inbound
	- Allow all outbound
3. Based on your [[target-research-for-phishing#Domain Name Research|domain name research]], purchase your desired source domain, set it up with a mail service like [[mailgun]] and ensure it [[mailgun#Verify Source Domain|gets verified by the mail service]].
