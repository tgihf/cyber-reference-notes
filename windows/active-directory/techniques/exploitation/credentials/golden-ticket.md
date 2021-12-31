# Golden Ticket Attack

> All ticket granting tickets (TGTs) are encrypted with the password hash of the `krbtgt` account. If you are able to discover this password or its hash, you can generate an TGT for any user in the domain (including a domain admin), giving you unrestricted access.

---

## Required pieces of information

1. The name of the user account to impersonate
    - Doesn't have to be a real user account
    - i.e., Administrator
2. The user ID of the user account to impersonate
    - i.e., 500
3. The name of the domain
    - i.e., hydra.test
4. The SID of the domain
    - i.e., S-1-5-21-849420856-2351964222-986696166
5. The NTLM hash of the Kerberos Ticket Granting Ticket (`krbtgt`) account

---

## (Mimikatz) Obtain domain SID & krbtgt NTLM hash

- Requires domain administrator privileges

Run `lsadump::lsa` against the `krbtgt` account to obtain the domain SID and its NTLM hash.

```powershell
mimikatz: lsadump::lsa /inject /name:krbtgt
```

![Obtaining information for golden ticket using Mimikatz's lsadump](golden-ticket-lsadump.png)

---

## Obtain Domain SID

Linux:
- [[lookupsid#Lookup a Domain and its Principals' SIDs|impacket-lookupsid]]

Windows:
- [[powershell-active-directory-module#Get-ADDomain|PowerShell Active Directory Module's Get-ADDomain]]
- [[powerview#Get Domain SID|PowerView's Get-DomainSID]]

---

## Obtain `krbtgt` NTLM

Linux:
- [[secretsdump#Dump NTDS dit from domain controller with domain admin credentials|impacket-secretsdump]]

---

## Create and Use a Golden Ticket

Linux:
- [[ticketer|impacket-ticketer]]

Windows:
- [[mimikatz#Create and Use a golden ticket|mimikatz]]
