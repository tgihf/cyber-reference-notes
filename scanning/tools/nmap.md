# nmap

The de facto network scanner.

## Targeted scan of $PORTS on $TARGET

- $PORTS* is a comma-separated list of port numbers or a range
  - Example: 80,443,445 or 1-1000

```bash
nmap -sC -sV -O -p$PORTS $TARGET -oA $OUTPUT_FILENAME
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