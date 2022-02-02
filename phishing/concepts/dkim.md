# [Domain Keys Identified Mail](https://support.dnsimple.com/articles/dkim-record/)

The **Domain Keys Identified Mail (DKIM)** protocol is one of the two ways [[dmarc|DMARC]] ensures the authenticity of an email's source domain

DKIM prevents someone from spoofing the source of an email (i.e., sending an email from a domain they don't actually have access to). How does it do this?

1. When the source domain owner registers with an email service (like [[mailgun|MailGun]]), the email service puts them through a process of verifying their ownership of the domain. This involves instructing the domain owner to create a [[dns#TXT Record https support dnsimple com articles txt-record|TXT record]] mapping a subdomain specified by the email service (i.e., `k1_domainkeys.tgihf.click`) to a public key also specified by the email service, like so:

| Domain | Public Key |
| --- | --- |
| k1_domainkeys.tgihf.click | "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIf..." |

2. Once the email service has verified the creation of this [[dns#TXT Record https support dnsimple com articles txt-record|TXT record]], they consider the domain "verified."
3. When someone from the verified domain attempts to send an email using the email service, the email service will create a digital signature of the contents of the email with its own private key (which is in the same pair as the public key in the DKIM [[dns#TXT Record https support dnsimple com articles txt-record|TXT]] record). The email service will attach this digital signature to the email and send it off.
4. During its [[dmarc|DMARC]] checks, the recipient's email client software will detect the DKIM digital signature and verify its authenticity using the public key from the DKIM [[dns#TXT Record https support dnsimple com articles txt-record|TXT]] record of the source domain. If it passes the DKIM check, this assures the recipient that the email service vouches that (1) the email actually came from the source domain (authenticity) and (2) hasn't been modified in transit (integrity).

---

## References

[dmarcian on YouYube - DKIM Overview](https://www.youtube.com/watch?v=yHv1OPcc-gw)
