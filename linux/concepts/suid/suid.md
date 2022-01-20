# Set owner User ID (SUID)

> A special type of file permission that allows the executor of a file to inherit the permission context of the owner of the file when executing.

---

## Find SUID Files

```bash
find / -perm -u=s -type f -print 2>/dev/null
```

---

## Determine If a SUID File Can Be Abused

Lookup the file on [GTFOBins](https://gtfobins.github.io/).
