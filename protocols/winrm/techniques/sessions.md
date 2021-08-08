# WinRM Sessions

## Create credential object with `$USERNAME` and `$PASSWORD`

```powershell
$CREDENTIAL = New-Object System.Management.Automation.PSCredential($USERNAME$, (ConvertTo-SecureString -String $PASSWORD -AsPlainText -Force))
```

---

## Create credential object from prompt

```powershell
$CREDENTIAL = Get-Credential
```

---

## Create a WinRM session on `$REMOTE_IP` with `$CREDENTIAL`

```powershell
$SESSION = New-PSSession -ComputerName $REMOTE_IP -Credential $CREDENTIAL
```
