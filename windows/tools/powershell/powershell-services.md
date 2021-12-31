# Interacting with Services via PowerShell

---

## List Services

```powershell
Get-Service
```

---

## List Services with Executable Path Included

```powershell
Get-WmiObject win32_service | select Name, DisplayName, State, PathName
```
