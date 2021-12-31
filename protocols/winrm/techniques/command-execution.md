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

---

## Check if Credentials Grant WinRM Access

[[crackmapexec#General Syntax Pass a credential s to a target s to check for access]]

---

## Extensible WinRM Shell from a Linux Machine

[[evil-winrm]]