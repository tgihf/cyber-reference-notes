# PowerShell [ActiveDirectory](https://docs.microsoft.com/en-us/powershell/module/addsadministration/?view=win10-ps) Module

PowerShell module for administering an Active Directory environment

## Get-ADDomain

Pulls information on the domain, including its domain controllers. Juicy fields:

* NetBIOSName
* DNSRoot
* InfrastructureMaster

```powershell
Get-ADDomain
```

## Get-ADForest

Pulls domains from a forest.

```powershell
Get-ADForest | Select-Object Domains
```

## Get-ADTrust

Provides information on the trusts within the Active Directory Domain, including the direction of the trust and its source and target.

```powershell
Get-ADTrust -Filter * | Select-Object Direction, Source, Target
```

## Get Domain SID

```powershell
Get-ADDomain
```
