# smbmap

> SMB enumeration.

---

## List SMB shares of $TARGET

```bash
smbmap -H $TARGET -u $USERNAME [-d $DOMAIN] -p $PASSWORD
```

---

## List SMB shares of $TARGET via null session

```bash
smbmap -P 445 -H $TARGET
```

---

## List SMB shares of $TARGET via guest session

```bash
smbmap -u "guest" -p "" -P 445 -H $TARGET
```
