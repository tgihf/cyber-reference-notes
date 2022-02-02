# [Domain Name System](https://www.cloudflare.com/learning/dns/what-is-dns/)

> The phonebook of the Internet. Its primary purpose is to translate domain names into IP addresses and vice versa.

---

## [Record Types](https://simpledns.plus/help/dns-record-types)

### [A Record](https://simpledns.plus/help/a-records)

Maps a domain name to an IPv4 address.

| Doman Name | IPv4 | TTL |
| --- | --- | --- |
| v4.tgihf.click | 10.10.10.10 | 3600 |

### [AAAA Record](https://simpledns.plus/help/aaaa-records)

Maps a domain name to an IPv6 address.

| Domain Name | IPv6 | TTL |
| --- | --- | --- |
| v6.tgihf.click | 2001:0db8:85a3:0000:0000:8a2e:0370:7334 | 3600 |

### [NS Record](https://simpledns.plus/help/ns-records)

Indicates which DNS server is authoritative for a particular domain.

| Domain | Name Server |
| --- | --- |
| tgihf.click | ns1.tgihf.click |

### [PTR Record](https://simpledns.plus/help/ptr-records)

Maps an IPv4 or IPv6 address to a domain name.

| Address | Domain Name | TTL |
| --- | --- | --- |
| 10.10.10.30 | ptr.tgihf.click | 3600 |

### [CNAME Record](https://support.dnsimple.com/articles/cname-record/)

Maps one hostname to another hostname.

| Hostname1 | Hostname2 |
| --- | --- |
| www.tgihf.click | tgihf.click |

In this example, `www.tgihf.click` will always redirect to `tgihf.click`. If the IP address of `tgihf.click` changes, you only need to update that A record to still be able to access the same IP via `www.tgihf.click`.

### [TXT Record](https://support.dnsimple.com/articles/txt-record/)

Associates text data with a hostname.

| Hostname | Data |
| --- | --- |
| www.tgihf.click | Primary domain |

---

## Domain Keys Identified Mail (DKIM)

See [[dkim|here]].

---

## [[enumeration#Attempt Zone Transfer from a DNS Server|Zone Transfer]]

---

## [[dynamic-dns|Dynamic DNS]]

---

## Commercial Domain Name Services

- [AWS Route 52](https://aws.amazon.com/route53/)
- [GoDaddy](https://www.godaddy.com/)
- [domain.com](https://www.domain.com/domains/)
- [name.com](https://www.name.com/)
- [Name Cheap](https://www.namecheap.com/)
