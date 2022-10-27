# Active Directory Discretionary Access Control Lists (DACLs) & Access Control Entries

> An access control list (ACL) is an ordered list of access control entries (ACEs) that define the protections that apply to an object and its properties. Each ACE specifies a **security principal** and a **set of access rights** that are allowed, denied, or audited for that security principal. There are several access rights that allow a great deal of control over [[objects]]. An object's ACLs are set by its owner.

---

## Permissions of Interest

- `GenericAll`
	- Full access to the [[objects|object]]
		- [[ASREP-roasting#Disable a Pre-Authentication for a Principal Targeted ASREP Roasting|Targeted ASREP Roasting]]
		- [[kerberoasting#Add a SPN to a Target Principal|Targeted Kerberoasting]]
		- If user, add user to a target group
		- If group, add target user to the group
		- Reset principal's password
- `GenericWrite`
	- Update an [[objects|object's]] attributes
		- Configure a logon script
		- [[ASREP-roasting#Disable a Pre-Authentication for a Principal Targeted ASREP Roasting|Targeted ASREP Roasting]]
		- [[kerberoasting#Add a SPN to a Target Principal|Targeted Kerberoasting]]
		- Configure the principal with [[unconstrained-delegation|unconstrained delegation]] or [[constrained-delegation|constrained delegation]]
- `WriteOwner`
	- Change the [[objects|object's]] owner to the attacker, granting full control of the [[objects|object]] (see `GenericAll`)
- `WriteDACL`
	- Modify the [[objects|object's]] ACEs and grant the attacker one of the other permissions of interest (i.e., `GenericAll` or `WriteOwner`)
- `WriteProperty`
	- If user, add user to a target group
	- If group, add target user to the group
- `AllExtendedRights`
	- If user, add user to a target group
	- If group, add target user to the group
	- Reset principal's password
- `ForceChangePassword`
	- Reset principal's password
- `Self (Self-Membership)`
	- If user, add user to a target group
	- If group, add target user to the group

---

## Determine How Exactly to Exploit a Particular DACL's ACE

[BloodHound's documentation on its graphs' edges](https://bloodhound.readthedocs.io/en/latest/data-analysis/edges.html) describe how exactly to exploit a particular type of principal (i.e., user, computer, group, domain) given a particular permission (i.e., `WriteDACL`, `GenericAll`, etc.). Just follow the link and Ctrl-F for the particular permission you're looking to exploit.

---

## Retrieve an Object's DACL (requires domain user credentials)

- From a Linux machine:
	- [[bloodhound|BloodHound's Python collector]]
		- BloodHound will actually map the relationships between the objects according to their DACLs--highly recommend going this route if possible

- From a domain-joined Windows machine (must be in the context of a domain user)
	- [[bloodhound|BloodHound's C# or PowerShell collector]]
		- BloodHound will actually map the relationships between the objects according to their DACLs--highly recommend going this route if possible
	- [[powerview#Retrieve an Object's DACL|PowerView]]
	- [[sharpview#Retrieve an Object's DACL|SharpView]]

---

## Add an ACE to an Principal's DACL

- From a Windows machine (must be in the context of a domain user)
	- [[powerview#Add an ACE to a Principal's DACL|PowerView]]

---

## References

[ired.team's Entry on Exploiting Active Directory DACLs & ACEs](https://www.ired.team/offensive-security-experiments/active-directory-kerberos-abuse/abusing-active-directory-acls-aces)
