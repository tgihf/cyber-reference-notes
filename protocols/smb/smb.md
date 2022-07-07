# [Server Message Block (SMB)](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831795(v=ws.11))

> A network file sharing protocol that allows applications on a computer to read and write to files and to request services from server programs in a computer network.

---

## Enumerate shares, users, groups, & more

See [[enum4linux|here]].

---

## List SMB shares on target

See [[list-shares|here]].

---

## Browse SMB shares on target

See [[browse-shares|here]].

---

## Exfil file on SMB shares

See [[exfil-shares|here]].

---

## List Named Named Pipes (Windows)

```powershell
ls \\$HOST\pipe
```

- `$HOST` can be `.` for local pipes

