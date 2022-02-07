# ACL Interaction via PowerShell

---

## View an Object's DACL

```powershell
Get-Acl $PATH_TO_FILE_OR_FOLDER
```

---

## View an Object's SACL

```powershell
Get-Acl -Audit $PATH_TO_FILE_OR_FOLDER
```

---

## View a Registry Key's DACL

```powershell
Get-Acl -Path $REGISTRY_KEY_PATH | fl
```

- `$REGISTRY_KEY_PATH` example: `HKLM:\System\CurrentControlSet\services`

---

## References

[[acls|Windows ACLs]]

[Microsoft PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/get-acl?view=powershell-7.2)
