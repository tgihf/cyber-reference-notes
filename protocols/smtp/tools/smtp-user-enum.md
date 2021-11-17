# [smtp-user-enum](https://github.com/pentestmonkey/smtp-user-enum)

---

## Check if a User Exists on an SMTP Server

```bash
smtp-user-enum -M $METHOD -u $EMAIL_ADDRESS -t $TARGET_FQDN_OR_IP
```

- `$METHOD` is either `RCPT`, `EXPN`, or `VRFY`. You might want to try all three.

---

## Enumerate Users on an SMTP Server

```bash
smtp-user-enum -M $METHOD -U $EMAIL_ADDRESSES_FILE -t $TARGET_FQDN_OR_IP
```

- `$METHOD` is either `RCPT`, `EXPN`, or `VRFY`. You might want to try all three.
