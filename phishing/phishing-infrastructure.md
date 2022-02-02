# Phishing Infrastructure

---

## Phishing Infrastructure Setup Process

1. Set up a single Debian-flavored Linux virtual private server (i.e., [AWS EC2 instance](https://aws.amazon.com/ec2/), [Digital Ocean droplet](https://www.digitalocean.com/products/droplets), [Azure virtual machine](https://azure.microsoft.com/en-us/services/virtual-machines/)) that will host:
	- The [[gophish]] server
	- The [[evilginx2]] proxy
2. Set the following firewall rules (i.e., EC2's Security Group rules) on the VPS:
	- Allow TCP 22 (SSH) inbound
	- Allow TCP/UDP 53 (DNS) inbound
	- Allow TCP 80 (HTTP) inbound
	- Allow TCP 443 (HTTPS) inbound
	- Allow TCP 3333 ([[gophish]] admin interface) inbound
	- Deny all else inbound
	- Allow all outbound
3. Based on your [[target-research-for-phishing#Domain Name Research|domain name research]], purchase your desired source domain, connect it to a mail service like [[mailgun|MailGun]] and ensure it [[mailgun#Verify Source Domain|gets verified by the mail service]].
4. [[gophish#Installation|Install GoPhish]]

If the phish is **credential-based**, continue with the following:

5. Install and [[evilginx2#Configure for Phishing|configure]] `evilginx2`
6. [[evilginx2#Load a Phishlet|Load the evilginx2 phishlet]]
7. [[evilginx2#Enable a Phishlet|Enable the evilginx2 phishlet]]
8. [[evilginx2#Generate a Phishing URL|Generate a URL]] for the phish
		
If the phish is **payload-based**, continue with the following:

5. Setup C2 infrastructure
6. Generate payloads tied to your C2 infrastructure
	- [[office-macro-generation|Microsoft Office macro generation]]
7. Host payloads and get their respective URLs for the phish

---

## Phishing Infrastructure De-provision Process

1. Offer to transfer the phishing domain to the client
2. Unlink the domain from your email service provider
3. Delete all the DNS records from the domain
4. Take down the VPS hosting the phishing server and the malicious website/proxy
