# [PowerView](https://github.com/PowerShellMafia/PowerSploit/tree/master/Recon) - offensive PowerShell module for enumeration and exploitation of an Active Directory environment

## Get-NetDomain

Gathers information about the domain, including forest name, domain controllers, and domain name. A more concise version of the ActiveDirectory module's *Get-ADDomain*.

```powershell
Get-NetDomain
```

## Get-NetDomainController

Lists all of the domain controllers in the network.

```powershell
Get-NetDomainController
```

## Get-NetForest

Gathers information on the forest, including all associated domains, the root domain, and the domain controllers for the root domain. Similar to the ActiveDirectory module's *Get-ADForest*.

```powershell
Get-NetForest
```

## Get-NetDomainTrust

Gathers information on the trusts in the domain, including direction, source, and target. A more concise version of the ActiveDirectory module's *Get-ADTrust*.

```powershell
Get-NetDomainTrust
```
