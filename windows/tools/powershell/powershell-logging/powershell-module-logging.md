# PowerShell Module Logging

Similar to [[powershell-session-transcripts|PowerShell transcript logging]], except it is activated by different registry keys and may not contain all of the details of the execution.

---

## Check if Module Logging is Enabled

Check the following registry keys (via [[reg#Retrieve Registry Key|cmd]], [[powershell-registry#Retrieve Registry Key|PowerShell]], etc.) to determine if module logging is enabled.

```txt
HKCU\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
HKLM\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
HKCU\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
HKLM\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
```

---

## Retrieve Last `$N` Module Logging Events

If module logging is enabled, run the following to view the last `$N` logged events.

```powershell
Get-WinEvent -LogName "windows Powershell" | select -First $N | Out-GridView
```

---

## References

[HackTricks](https://book.hacktricks.xyz/windows/windows-local-privilege-escalation)
