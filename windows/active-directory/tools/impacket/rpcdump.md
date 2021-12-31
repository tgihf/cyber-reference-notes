# impacket-rpcdump

> Python script that "dumps the remote RPC enpoints information via epmapper."

---

## Determine if a Computer has the Print Spooler Service Enabled (credentials may be required)

```bash
impacket-rpcdump [$DOMAIN/]$USERNAME[:$PASSWORD]@$TARGET_FQDN_OR_IP [-hashes $LMHASH:NTLMHASH] | grep MS-RPRN -A 6
```

- `$PASSWORD` or `-hashes` is required
