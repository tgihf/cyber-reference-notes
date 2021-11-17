# SharpView

---

## Gather Users who don't Require [[kerberos#Kerberos Pre-Authentication|Kerberos Pre-Authentication]]

```powershell
SharpView.exe Get-DomainUser -KerberosPreauthNotRequired
```

---

## Gather Computers Configured with [[unconstrained-delegation|Unconstrained Delegation]]

Must be executed in the context of a domain user account.

```powershell
SharpView.exe Get-DomainComputer -Unconstrained
```

---

## Gather Computers & Users Configured with [[constrained-delegation|Constrained Delegation]]

Must be executed in the context of a domain user account.

```powershell
SharpView.exe Get-DomainComputer -TrustedToAuth [-Properties msDs-AllowedToDelegateTo,samAccountName,dnsHostName]
SharpView.exe Get-NetComputer -TrustedToAuth [-Properties msDs-AllowedToDelegateTo,samAccountName,dnsHostName]
```

```powershell
SharpView.exe Get-DomainUser -TrustedToAuth [-Properties msDs-AllowedToDelegateTo,samAccountName]
SharpView.exe Get-NetUser -TrustedToAuth [-Properties msDs-AllowedToDelegateTo,samAccountName]
```

---

## Return Users that **are not** Marked as "Sensitive and Not Allowed for Delegation"

```powershell
SharpView.exe Get-DomainUser -AllowDelegation
SharpView.exe Get-NetUser -AllowDelegation
```

---

## Return Users that **are** Marked as "Sensitive and Not Allowed for Delegation"

```powershell
SharpView.exe Get-DomainUser -DisallowDelegation
SharpView.exe Get-NetUser -DisallowDelegation
```

---

## Retrieve an Object's DACL

### Retrieve a User's DACL

```powershell
SharpView.exe Get-DomainObjectAcl [-SamAccountName $SAM_ACCOUNT_NAME] -ResolveGUIDs -Rights $PERMISSION[,$PERMISSION2...]
```

- `$SAM_ACCOUNT_NAME` of the user account
- `$PERMISSION` is the permission to filter for
	- [[dacls-aces#Permissions of Interest|Here's some permissions of interest]]

### Retrieve a Group's DACL

You'll need the distinguished name of the group.

```powershell
Get-DomainGroup -Identity $GROUP_NAME -Properties DistinguishedName
```

Example distinguished name: `CN=Domain Admins,OU=Groups,DC=MARVEL,DC=test`.

Retrieve the group's DACL with the distinguished name.

```powershell
SharpView.exe Get-DomainObjectAcl -DistinguishedName $DISTINGUISHED_NAME -ResolveGUIDs -Rights $PERMISSION
```

- `$PERMISSION` is the permission to filter for
	- [[dacls-aces#Permissions of Interest|Here's some permissions of interest]]

### Retrieve a Computer's DACL

Same procedure as [[sharpview#Retrieve a User's DACL|retrieving a user's DACL]] except you use the `$SAM_ACCOUNT_NAME` of the computer.

### Convert SID To Object Name

This may come in handy, as many object's ACEs designate the subject by its SID.

```powershell
SharpView.exe Convert-ADName -ObjectName $SID
```
