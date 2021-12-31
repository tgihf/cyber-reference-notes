# PowerShell Script Block Logging

PowerShell script block logging records blocks of PowerShell code as they are executed. This setting is enabled in the regsitry and the recorded blocks of code are saved as events.

---

## Check if Script Block Logging is Enabled

Check the following registry keys (via [[reg#Retrieve Registry Key|cmd]], [[powershell-registry#Retrieve Registry Key|PowerShell]], etc.) to determine if script block logging is enabled.

```txt
HKCU\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging
HKLM\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging
HKCU\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging
HKLM\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging
```

---

## View Logged Script Blocks

In `Windows Event Viewer` under the path `Application and Service Logs` -> `Microsoft` -> `Windows` -> `Powershell` -> `Operational`.

In `PowerShell`, run the following to retrieve the last `$N` logged script block events.

```powershell
Get-WinEvent -LogName "Microsoft-Windows-Powershell/Operational" | select -first $N | Out-Gridview
```

---

## References

[HackTricks](https://book.hacktricks.xyz/windows/windows-local-privilege-escalation)
