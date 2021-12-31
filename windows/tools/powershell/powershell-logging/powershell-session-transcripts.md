# PowerShell Transcript Files

By default, transcripts of PowerShell sessions are not saved. However, by setting a couple of registry key entries (generally through a Group Policy), it is possible to enable PowerShell transcript logging. These files can be useful for an attacker as they reveal a user's activity on the host.

---

## Check if Transcript Logging is Enabled

Check the following registry keys (via [[reg#Retrieve Registry Key|cmd]], [[powershell-registry#Retrieve Registry Key|PowerShell]], etc.) to determine if transcript logging is enabled.

```txt
HKCU\Software\Policies\Microsoft\Windows\PowerShell\Transcription
HKLM\Software\Policies\Microsoft\Windows\PowerShell\Transcription
HKCU\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\Transcription
HKLM\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\Transcription
```

---

## Default Transcript File Folder

When PowerShell transcript logging is enabled, logs are by default written to `C:\Transcripts\`.

---

## References

[HackTricks](https://book.hacktricks.xyz/windows/windows-local-privilege-escalation)

