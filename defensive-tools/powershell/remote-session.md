# Remote PowerShell Session

## Start Remote Session with $IP

```powershell
# In Administrator prompt
Enable-PSRemoting
Set-NetConnectionProfile -InterfaceAlias * -NetworkCategory Private
Set-Item WSMan:\localhost\Client\TrustedHosts -Value $IP
$s = New-PSSession -ComputerName $IP -Credential (Get-Credential)
Invoke-Command -Session $s -ScriptBlock { whoami }
```

## Execute Command in Session $s

```powershell
Invoke-Command -Session $s -ScriptBlock { whoami }
```

## Interact with Session $s

```powershell
Enter-PSSession -Session $s
```