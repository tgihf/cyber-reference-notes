# [enum4linux](https://github.com/CiscoCXSecurity/enum4linux)

> A Linux alternative to enum.exe for enumerating data from Windows and Samba hosts. Capable of enumerating domain, nbtstat, OS, users, groups, shares, password policy.

---

## Perform All Checks (null session)

```bash
enum4linux -a $HOST
```

---

## Perform All Checks (guest session)

```bash
enum4linux -a -u "guest" -p "" $HOST
```
