# Resource-Based Constrained Delegation

Windows Server 2012 implemented a new type of constrained delegation in response to some of the problems with [[constrained-delegation|traditional constrained delegation]]: resource-based constrained delegation.

In [[constrained-delegation|traditional constrained delegation]], the account configured with constrained delegation specifies which [[service-principal-name|SPNs]] it can delegate to.

In resource-based constrained delegation, the resource itself (i.e., the computer object hosting the service) specifices which other computer objects are allowed to delegate to it. It's effectively the **reverse** of [[constrained-delegation|traditional constrained delegation]].

The primary abuse case for resource-based constrained delegation is when an attacker is attempting to compromise a particular computer account.

---

## Requirements

To abuse resource-based constrained delegation, an attacker needs two things:

1. Control over some account with a [[service-principal-name|SPN]] set (call it `ServiceA`)
	- A computer account, or
	- By default, any domain user account can create up to 10 computer accounts and configure each one with however many [[service-principal-name|SPNs]] it desires (using [PowerMad](https://github.com/Kevin-Robertson/Powermad))
2. `GenericAll`, `GenericWrite`, or `WriteDACL` permission to the target computer account (call it `ServiceB`)

---

## Process

1. Configure resource-based constrained delegation from `ServiceA` to `ServiceB` (requires `GenericAll`, `GenericWrite`, or `WriteDACL` permissions to `ServiceB`)
	- [[powershell-active-directory-module#Configure resource-based-constrained-delegation Resource-Based Constrained Delegation from ComputerA to ComputerB|PowerShell Active Directory Module]]
	- [[powerview#Configure resource-based-constrained-delegation Resource-Based Constrained Delegation from ComputerA to ComputerB|PowerView]]

2. Perform an S4U attack from `ServiceA` to `ServiceB` to generate a service ticket for any user with privileged access to `ServiceB` (i.e., a domain administrator)

```powershell
Rubeus.exe s4u /user:$SERVICE_A /rc4:$HASH /impersonateuser:$USER_TO_IMPERSONATE /msdsspn:$SPN /ptt
```

- `$SERVICE_A`: SAM account name of `ServiceA`
- `$HASH`: RC4 HMAC hash of `ServiceA`
	- [[windows/active-directory/tools/rubeus#Generate the RC4 HMAC of a Domain Account's Password|Generate the RC4 HMAC of a domain account's password]]
- `$SPN`: [[service-principal-name|SPN]] on target computer (`ServiceB`)
	- For takeover, recommend `HOST` or `cifs` services (i.e., `cifs/ServiceB`)

3. Pass the ticket and impersonate the user to gain privileged access to `ServiceB`

4. Cleanup by clearing the `msds-allowedtoactonbehalfofotheridentity` attribute of the target computer account (`ServiceB`)
	- [[powerview#Cleanup After resource-based-constrained-delegation Resource-Based Constrained Delegation Attack|PowerView]]
	- [[powershell-active-directory-module#Cleanup After resource-based-constrained-delegation Resource-Based Constrained Delegation Attack|PowerShell Active Directory Module]]

---

## References

[Elad Shamir's In-Depth Writeup](https://shenaniganslabs.io/2019/01/28/Wagging-the-Dog.html)

[harmj0y's Summary](https://www.harmj0y.net/blog/redteaming/another-word-on-delegation/)

[Github gist of harmj0y Exploiting RBCD in PowerView](https://gist.github.com/HarmJ0y/a1ae1cf09e5ac89ee15fb3da25dcb10a)

[SpecterOps's Summary](https://posts.specterops.io/kerberosity-killed-the-domain-an-offensive-kerberos-overview-eb04b1402c61)

[HackTricks's Page on Constrained Delegation](https://book.hacktricks.xyz/windows/active-directory-methodology/resource-based-constrained-delegation)