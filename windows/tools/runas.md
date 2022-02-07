# [runas](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc771525(v=ws.11))

> A command-line tool that allows a user to run commands with different permissions than the user's current logon session provides.

---

## Run Command as Another User

```batch
runas /user:[$DOMAIN_NAME\]$USERNAME "$COMMAND $ARGS"
```

You'll be prompoted for `$USERNAME`'s password.

---

## Run Command as Another User for Remote Access Only

```batch
runas /user:[$DOMAIN_NAME\]$USERNAME "$COMMAND $ARGS" /netonly
```

You'll be prompoted for `$USERNAME`'s password.

---

## Run Command as Another User with Credential Saved in Windows Credential Manager

```batch
runas /savecred /user:[$DOMAIN\]$USERNAME "$COMMAND $ARGS"
```
