# [Sender Policy Framework](https://support.dnsimple.com/articles/spf-record/#:~:text=An%20SPF%20record%20is%20a,and%20clarified%20by%20RFC%207208.)

The **Sender Policy Framework (SPF)** protocol is one of the two ways [[dmarc|DMARC]] ensures the authenticity of an email's source domain.

SPF attempts to prevent someone from spoofing the source of an email (i.e., sending an email from a domain they don't actually have access to). How does it do this?

1. The owner of the domain creates a [[dns#TXT Record https support dnsimple com articles txt-record|TXT]] record specifying the IPv4 addresses, IPv6 addresses, and/or DNS names that are authorized to send mail on behalf of the domain, like so:

| Domain | SPF TXT Record |
| --- | --- |
| tgihf.click | v=spf1 ip4:40.113.200.201 ip6:2001:db8:85a3:8d3:1319:8a2e:370:7348 include:thirdpartydomain.com ~all

2. During its [[dmarc|DMARC]] checks, the receiver's email client software retrieves the SPF [[dns#TXT Record https support dnsimple com articles txt-record|TXT]] record of the source domain and checks to see if it received it from one of the specified addresses/domain names. If it did, the SPF check passes.

---

## Determine if Domain is Spoofable

- [[spoofcheck|spoofcheck]]

---

## References

[demarcian on YouTube - SPF Overview](https://www.youtube.com/watch?v=WFPYrAr1boU)
