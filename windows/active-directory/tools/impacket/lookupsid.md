# impacket-lookupsid

> Python tool for looking up a domain and its principals' SIDs.

---

## Lookup a Domain and its Principals' SIDs

```bash
impacket-lookupsid $DOMAIN/$USERNAME[:$PASSWORD]@$DOMAIN_CONTROLLER_FQDN_OR_IP
```

A domain principal's SID is the domain's SID + `-` + the domain principal's ID. For example, if the domain SID is `S-1-5-21-4220043660-4019079961-2895681657` and the domain principal's ID is `1103`, then the domain principal's SID is `S-1-5-21-4220043660-4019079961-2895681657`.