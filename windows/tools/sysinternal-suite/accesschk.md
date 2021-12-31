# [SysInternals Suite's accesschk](https://docs.microsoft.com/en-us/sysinternals/downloads/accesschk)

---

## Determine the Effective Access of a Particular Windows Service

```cmd
accesschk.exe -accepteula -ucqv $SERVICE_NAME
```

---

## Determine the Services that All Members of `$GROUP` Can Write To

```cmd
accesschk.exe -accepteula -uwcqv "$GROUP" *
```
