# [cmdkey](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/cmdkey)

> Creates, lists, and deletes stored user names and passwords or credentials.

---

## Display a List of All Stored Usernames & Credentials

```batch
cmdkey /list
```

---

## Store a Username and Password

```batch
cmdkey /add:$TARGET /user:$USERNAME /pass:$PASSWORD
```

- `$TARGET` identifies the computer or domain name that this entry will be associated with