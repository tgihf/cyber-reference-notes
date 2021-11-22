# [PowerShell ActiveDirectory Module](https://docs.microsoft.com/en-us/powershell/module/addsadministration/?view=win10-ps)

> Microsoft's PowerShell module for administering an Active Directory environment.

---

## Get-ADDomain

Pulls information on the domain, including its domain controllers. Juicy fields:

* NetBIOSName
* DNSRoot
* InfrastructureMaster

```powershell
Get-ADDomain
```

---

## Get-ADForest

Pulls domains from a forest.

```powershell
Get-ADForest | Select-Object Domains
```

---

## Get-ADTrust

Provides information on the trusts within the Active Directory Domain, including the direction of the trust and its source and target.

```powershell
Get-ADTrust -Filter * | Select-Object Direction, Source, Target
```

---

## Get Domain SID

```powershell
Get-ADDomain
```

---

## Gather Computers & Users Configured with [[unconstrained-delegation|Unconstrained Delegation]]

Must be executed in the context of a domain user account.

```powershell
Get-ADComputer -LDAPFilter  "(userAccountControl:1.2.840.113556.1.4.803:=524288)"
```

```powershell
Get-ADUser -LDAPFilter "(userAccountControl:1.2.840.113556.1.4.803:=524288)"
```

---

## Gather Computers & Users Configured with [[constrained-delegation|Constrained Delegation]]

Must be executed in the context of a domain user account.

```powershell
Get-ADComputer -LDAPFilter "(userAccountControl:1.2.840.113556.1.4.803:=16777216)" -Properties msDs-AllowedToDelegateTo
```

```powershell
Get-ADUser -LDAPFilter "(userAccountControl:1.2.840.113556.1.4.803:=16777216)" -Properties msDs-AllowedToDelegateTo
```

---

## Configure [[resource-based-constrained-delegation|Resource-Based Constrained Delegation]] from `ComputerA` to `ComputerB`

`ComputerB` is specifying that `ComputerA` is allowed to delegate to it.

Requires `GenericAll`, `GenericWrite`, or `WriteDACL` permission to `ComputerB`.

```powershell
Set-ADComputer $COMPUTER_B -PrincipalsAllowedToDelegateToAccount $COMPUTER_A

# (Optional) Check that it worked
Get-ADComputer $COMPUTER_B -Properties PrincipalsAllowedToDelegateToAccount
```

- `$COMPUTER_B`: SAM account name
- `$COMPUTER_A`: SAM account name

---

## Cleanup After [[resource-based-constrained-delegation|Resource-Based Constrained Delegation Attack]]

Clear the `msds-allowedtoactonbehalfofotheridentity` attribute from the target computer.

```powershell
Set-ADComputer $TARGET -PrincipalsAllowedToDelegateToAccount $null
```

---

## Retrieve Deleted Active Directory Objects

This requires permission to the `AD Recycle Bin` group.

```powershell
Get-ADObject -Filter 'Deleted -eq $true' -IncludeDeletedObjects
```

Pipe the results of this command into a `where` clause for further filtering.

---

## Restore a Deleted Active Directory Object

This requires permission to the `AD Recycle Bin` group.

First, you'll need to [[powershell-active-directory-module#Retrieve Deleted Active Directory Objects|retrieve the deleted Active Directory object]]. Pipe that object into `Restore-ADObject`, like so:

```powershell
Get-ADObject -Filter '$FILTER' -IncludeDeletedObjects | RestoreADObject
```
