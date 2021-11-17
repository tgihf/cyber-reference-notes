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
