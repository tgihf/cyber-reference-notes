# Scheduled Tasks in PowerShell

---

## List All Scheduled Tasks

```powershell
Get-ScheduledTask
```

---

## Show Commands Ran by All Schedule Tasks

```powershell
Get-ScheduledTask | Select-Object TaskName -ExpandProperty Actions | Select-Object TaskName, Execute
```

---

## Show Command Ran by Particular Scheduled Task with name `$TASK_NAME`

```powershell
Get-ScheduledTask | Select-Object TaskName -ExpandProperty Actions | Select-Object TaskName, Execute | Where-Object TaskName -Match $TASK_NAME
```
