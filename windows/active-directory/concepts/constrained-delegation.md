# [Constrained Delegation](https://docs.microsoft.com/en-us/windows-server/security/kerberos/kerberos-constrained-delegation-overview)

Constrained delegation was introduced in Windows Server 2003 to provide a more secure alternative to [[unconstrained-delegation|Unconstrained Delegation]]. 

Constrained delegation allows a principal (think user or computer) to authenticate as any principal to a set of specific services (identified by [[service-principal-name|SPNs]]). That is, a principal with this privilege can impersonate any domain principal (including domain administrators) to the specific service on the target host.

An issue exists in the constrained delegation implementation where the service name (`sname`) field of the resulting service ticket is not part of the protected ticket information, allowing an attacker to modify the target service name to any service of their choice. The result is complete server compromise.

From the perspective of the principal configured with constrained delegation, the process is comprised of the following steps:

1. `S4U2Self`: The attacker compromises a domain principal configured with constrained delegation. From that context, they request a special, "forwardable" service ticket for the principal to impersonate to the principal configured with constrained delegation that the attacker has control over.
2. `S4U2Proxy`: The constrained delegation principal sends the "forwardable" service ticket to the target [[service-principal-name|SPN]] and receives a service ticket for that [[service-principal-name|SPN]] in the response.
3. `Changing the sname`: With a valid service ticket to the target [[service-principal-name|SPN]], the attacker can now modify the service ticket's service name (`sname`) attribute to access any service on the [[service-principal-name|SPN's]] computer.

---

## Caveat

A principal with constrained delegation to a particular [[service-principal-name|SPN]] can impersonate any domain principal to that SPN **EXCEPT FOR** users in the `Protected Users` security group or whose constrained delegation privileges have been otherwise revoked. Always make sure the user you're trying to impersonate isn't in this group before attemping it.

---

## Indicator that a Domain Computer is Configured with Constrained Delegation

Its object representation's `userAccountControl` attribute contains the value `TRUSTED_TO_AUTH_FOR_DELEGATION`. Its object representation's `msDs-AllowedToDelegate` attribute contains all the [[service-principal-name|SPNs]] that the principal is allowed to delegate to.

---

## Determine if a Principal has Constrained Delegation and for which SPNs

From a Linux machine:
- [[bloodhound|BloodHound's Python collector]]
- [[pywerview#Gather Computers Users Configured with constrained-delegation Constrained Delegation|pywerview]]

From a domain-joined Windows machine (under the context of a domain user):
- [[bloodhound|BloodHound's PowerShell or C# collector]]
- [[powerview#Gather Computers Users Configured with constrained-delegation Constrained Delegation|PowerView]]
- [[sharpview#Gather Computers Users Configured with constrained-delegation Constrained Delegation|SharpView]]
- [[powershell-active-directory-module#Gather Computers Users Configured with constrained-delegation Constrained Delegation|PowerShell Active Directory module]]

When using [[bloodhound|BloodHound]]:

Select the prebuilt analytic query "Shortest Paths to Unconstrained Delegation Systems." Note the principals that have the `AllowedToDelegate` privilege and to what  [[service-principal-name|SPNs]]. If a principal has this privilege, then they have constrained delegation on those [[service-principal-name|SPNs]].

---

## Abuse a Constrained Delegation Privilege to Generate a Service Ticket for Any User to a Host for which a SPN is Configured

- From a Linux machine:
	- [[getST#Abuse a Constrained Delegation Privilege to Generate a Service Ticket for Any User to a Host for which a SPN is Configured from Linux|impacket-getST]]
- From a domain-joined Windows machine:
	- [[windows/active-directory/tools/rubeus#Abuse a constrained-delegation Constrained Delegation Privilege to Generate a Service Ticket for Any User to a Host for which a SPN is Configured|Rubeus]]
	- [[c2-frameworks/covenant/tasks/Rubeus#Abuse a constrained-delegation Constrained Delegation Privilege to Generate a Service Ticket for Any User to a Host for which a SPN is Configured|Covenant's Rubeus Task]]

---

## More Resources

https://www.ired.team/offensive-security-experiments/active-directory-kerberos-abuse/abusing-kerberos-constrained-delegation
