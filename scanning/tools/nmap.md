# [nmap](https://nmap.org/)

> The de facto network scanner.

---

## Open TCP port discovery scan of `$TARGET`

```bash
nmap -p- --min-rate=10000 $TARGET -oA $OUTPUT_FILENAME
```

---

## Open TCP port enumeration scan of `$PORTS` on `$TARGET`

- `$PORTS` is a comma-separated list of port numbers or a range
  - Example: 80,443,445 or 1-1000

```bash
nmap -sC -sV -p$PORTS $TARGET -oA $OUTPUT_FILENAME
```

---

## Open UDP port discovery scan of `$TARGET`

```bash
nmap -sU $TARGET
```

---

## List SMB shares

```bash
nmap -p 445 --script=smb-enum-shares.nse,smb-enum-users.nse $TARGET
```

---

## List NFS mounts

```bash
nmap -p 111 --script=nfs-ls,nfs-statfs,nfs-showmount $TARGET
```

- Use the above if NFS is bound on `rpcbind` port 111
- If NFS is listening on another port (default 2049), use it instead of 111

---

## Check for FTP anonymous login

```bash
nmap -p 21 --script=ftp-anon $TARGET
```

---

## Anonymously extract data from an LDAP server

```bash
nmap -n -sV --script "ldap* and not brute" $LDAP_SERVER_HOSTNAME_OR_IP
```
