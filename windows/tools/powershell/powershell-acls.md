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

## References

[[acls|Windows ACLs]]

[Microsoft PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/get-acl?view=powershell-7.2)
