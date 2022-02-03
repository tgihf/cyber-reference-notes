# PowerShell

---

## Create a Credential (`PSCredential` Object)

```powershell
$password = ConvertTo-SecureString -AsPlain $PASSWORD -Force
$credential = New-Object System.Management.Automation.PSCredential($USERNAME, $password)
```

---

## Recover the Plaintext Password from a `PSCredential` Object

```powershell
$bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($credential.Password)
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
```

---

## Download a File via HTTP(S)

```powershell
Invoke-WebRequest -Uri $URL -OutFile $OUTPUT_FILE_PATH
```

---

## Import a Remote PowerShell Module

Download the module and save it as a string in memory. Use `Invoke-Expression` to execute the string as actual PowerShell. This will define all of the functions for use on that line. This means that all the commands you need to execute from the module must be executed on the same line as the `Invoke-Expression` (`IEX`) statement.

```powershell
$module = (New-Object Net.Webclient).DownloadString("$REMOTE_MODULE_URL")
IEX $module; $COMMAND_1; $COMMAND_2; $COMMAND_N
```

---

## Query Operating System Information via WMI

```powershell
Get-CimInstance -ClassName "CIM_OperatingSystem"
```

---

## Query Operating System Version from .NET `Systen.Environment` Library

```powershell
[System.Environment]::OSVersion.Version
```

---

## Query Installed Updates via WMI

```powershell
Get-HotFix
```

```powershell
Get-CimInstance -ClassName "Win32_QuickFixEngineering"
```

---

## Query Installed Antivirus via WMI

```powershell
Get-CimInstance -Namespace root/securitycenter2 -ClassName antivirusproduct
```

---

## Query Environment Variables

```powershell
Get-Item Env:
```

---

## List Currently Running Processes

```powershell
Get-Process
```

---

## Query Network Adapters

```powershell
Get-NetAdapter
```

---

## Query Routing Table

```powershell
Get-NetRoute
```

---

## Query ARP Cache

```powershell
Get-NetNeighbor
```

---

## Query Network Listeners & Connections

```powershell
Get-NetIPConfiguration
```

---

## Query Local Users

```powershell
Get-LocalUser
```

---

## Query a Particular Local User

```powershell
Get-LocalUser $USERNAME
```

---

## Query Local Groups

```powershell
Get-LocalGroup
```

---

## Query a Particular Local Group

```powershell
Get-LocalGroup $GROUP_NAME
```

---

## Query SMB Shares

```powershell
Get-SmbShare
```

---

## Import a PowerShell Module

```powershell
Import-Module $PATH_TO_POWERSHELL_MODULE
```

---

## Add a Windows Defender Exclusion

In an administrative or SYSTEM context:

```powershell
Add-MpPreference -ExclusionPath $PATH_TO_FOLDER_TO_EXCLUDE
```

---

## Recursively Search the File System

```powershell
Get-ChildItem -Path C:\ -Include "$FILENAME" -Recurse -ErrorAction SilentlyContinue
```

- `$FILENAME` can contain wildcards

---

## Query Firewall Rules

```powershell
Get-NetFirewallRule
```

---

## Query AppLocker Policies

```powershell
Get-AppLockerPolicy
```

---

## Get PowerShell Version

```powershell
Get-Host | Select Version
```
