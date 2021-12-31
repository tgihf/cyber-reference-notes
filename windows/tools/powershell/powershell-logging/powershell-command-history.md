# PowerShell Command History

By default in Windows 10, PowerShell logs all of the commands executed by a particular user to `C:\Users\$USERNAME\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt`. You can also retrieve this path with the following:

```powershell
(Get-PSReadlineOption).HistorySavePath
```

```powershell
$env:AppData\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt
```

---

## References

[HackTricks](https://book.hacktricks.xyz/windows/windows-local-privilege-escalation)

[0xdf Hacks Stuff](https://0xdf.gitlab.io/2018/11/08/powershell-history-file.html)
