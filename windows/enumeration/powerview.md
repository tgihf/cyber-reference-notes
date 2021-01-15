# [PowerView](https://github.com/PowerShellMafia/PowerSploit/tree/master/Recon)

Offensive PowerShell module for enumeration and exploitation of an Active Directory environment

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

## Get-DomainUser

Gathers information on the users in the domain. A more concise version of the ActiveDirectory module's *Get-ADUser*.

```powershell
Get-DomainUser | select cn
```

## Get-DomainComputer

Gathers information on the computers in the domain.

```powershell
Get-DomainComputer | select name, operatingsystem
```

## Get-NetShare

Gathers information on the shares in the domain.

```powershell
Get-NetShare
```

## List group policy objects (GPOs)

```powershell
Get-NetGPO | select displayname, whenchanged
```

## List shares across the domain

```powershell
Invoke-ShareFinder
```

## Get Domain SID

```powershell
Get-DomainSID
```
