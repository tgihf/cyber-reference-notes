# Domain Controller Synchronization (DCSync)

> DCSync is a legitimate, necessary function of any Active Directory Domain Controller that allows it to synchronize the domain's data with any other domain controller via the Directory Replication Service Remote Protocol (MS-DRSR). With the right permissions, DCSync can be abused by adversaries to dump all the domain's credentials.

---

## The Three Required Privileges

To be able to execute a DCSync, you must have the following privileges over the domain:
1. `DS-Replication-Get-Changes`
2. `Replicating Directory Changes All`
3. `Replacating Directory Changes in Filtered Set`

By default, only the `Domain Admins`, `Enterprise Admins`, `Administrators`, and `Domain Controllers` groups have these privileges.

---

## Determine All Principals with the Required Privileges

From Windows:
- [[powerview#Determine All Principals Who Can Execute a dcsync DCSync|PowerView]]


---

## Execute a DCSync

From Linux:
- [[secretsdump#Dump NTDS dit from domain controller with domain admin credentials|impacket]]

From Windows:
- [[mimikatz#Dump Domain Hashes dcsync method|Mimikatz]]

---

## Add DCSync Privileges to a User

See [[powerview#Assign DCSync Privileges to a User|PowerView]].