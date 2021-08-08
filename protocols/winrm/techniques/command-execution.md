# Command Execution via WinRM

## Requires an active WinRM session

[[sessions]]

---

## Execute commands interactive in WinRM session `$SESSION`

```powershell
Enter-PSSession -Session $SESSION
```

---

## Execute commands uninteractively in WinRM session `$SESSION`

```powershell
Invoke-Command -Session $SESSION -ScriptBlock {
	$COMMANDS
}
```