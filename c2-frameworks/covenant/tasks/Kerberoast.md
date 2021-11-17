# Covenant's `Kerberoast` Task

---

## Kerberoast a Particular User

```cmd
Kerberoast $USERNAME $FORMAT
```

- `$USERNAME` is the username of the service account (**not** the full [[service-principal-name|SPN]])
- `$FORMAT`: `hashcat` or `john`
