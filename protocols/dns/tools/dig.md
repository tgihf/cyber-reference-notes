# dig

> Native Unix DNS lookup utility

---

## Reverse Lookup

A DNS reverse lookup queries for a [[dns#[PTR Record](https://simpledns.plus/help/ptr-records)|PTR record]] for a particular IP address.

```bash
dig @$DNS_SERVER_FQDN_OR_IP -x $IP_ADDRESS_TO_QUERY [+short]
```

---

## Attempt a Zone Transfer

```bash
dig @$DNS_SERVER_FQDN_OR_IP axfr $DOMAIN_NAME
```

