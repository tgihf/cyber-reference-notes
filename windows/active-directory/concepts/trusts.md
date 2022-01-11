# Active Directory Domain Trusts

## Quick Notes

An internal / intra-forest trust is a trust between two domains that are in the same forest.

By default, all domains within a forest have bidirectional trust relationships with each other. If you compromise one of these domains, you can likely compromise all the others.

An external / inter-forest trust is a trust between two domains that are not in the same forest.

**SID Filtering** prevents elevated users from a trusted domain from performing elevated actions on a trusting domain, if the two domains are in separate forests (external trust). This means that even if you compromise a domain and it is trusted by another external domain, you can't perform elevated actions on the trusting domain despite the existence of the trust. This is why `harmj0y` claims "the trust boundary is at the forest, not the domain." However, you can apprently still **enumerate** the trusting domain.

---

## Trust Direction

A trust between two entities can either be **unidirectional** or **bidirectional**.

If domain A has an outbound unidirectional trust with domain B, then principals in domain B can access resources in domain A, but principals in domain A can't access resources in domain B.

If domain A and domain B share a bidirectional trust, then principals in each domain can access resources in the other domain.

The direction of trust is the **opposite** of the direction of access. If A trusts B, then B can access A.

---

## Types of Trusts

### Parent/Child Trust

A trust between a parent domain `tgihf.click` and a child domain `dev.tgihf.click`.
- These domains are naturally part of the same forest
- The bidirectionality and transitivity of this trust means that all children domains have bidirectional trusts with each other (i.e., `dev.tgihf.click` and `prod.tgihf.click`)

| Default Bidirectional | Default Transitive | Enforces SID Filtering |
| --- | --- | --- |
| Y | Y | N |

### Cross-Link Trust

A trust between child domains (i.e., `dev.tgihf.click` and `prod.tgihf.click`) for the purpose of improving referral times, since referrals by default have to filter up to the forest root and then back down to the target domain. These domains are naturally part of the same forest.
- Also known as a **shortcut trust**
- No real security implications since the **Parent/Child** trust is enough to indicate bidirectionality and transitivity between all child domains
	
| Default Bidirectional | Default Transitive | Enforces SID Filtering |
| --- | --- | --- |
| Y | Y | N |

### External Trust

A trust between two domains that are **not** in the same forest and whose forests are not joined by a [[trusts#Forest Trust|forest trust]].

| Default Bidirectional | Default Transitive | Enforces SID Filtering |
| --- | --- | --- |
| N | N | Y |

### Forest Trust

A trust between one forest root domain and another forest root domain.

| Default Bidirectional | Default Transitive | Enforces SID Filtering |
| --- | --- | --- |
| Y | Y | Y |

### MIT Trust

A trust between a non-Windows RFC-4120-compliant Kerberos domain.

---

## Intra-Forest Trusts vs. Inter-Forest Trusts

Infra-forest trusts are those between domains in the same forest, including [[trusts#Parent Child Trust|Parent/Child trusts]], [[trusts#Cross-Link Trust|Cross-Link trusts]], and Tree-Root trusts. The implicit bidirectionality and transitivity of these trusts, along with their lack of [[trusts#SID Filtering|SID filtering]] have the following security implications:
- **Elevated access in the trusted domain indicates elevated access in the trusting domain**
	- i.e., an administrator in the trusted domain can perform administrative actions in the trusting domain
- **Unelevated access in the trusted domain indicates unelevated access in the trusting domain**
	- i.e., a non-administrator in the trusted domain can fully enumerate the trusting domain

Inter-forest trusts are those beween domains that are not in the same forest and whose forests don't share a [[trusts#Forest Trust|Forest trust]]. These are [[trusts#External Trust|External trusts]]. They are neither bidirectional nor transitive by default, so you'll have to pay attention to their settings. They also enforce [[trusts#SID Filtering|SID filtering]], which has the following security implications:
- **Elevated access in the trusted domain DOES NOT indicate elevated access in the trusting domain**
	- i.e., an administrator in the trusted domain CANNOT perform administrative actions in the trusting domain
- **Unelevated access in the trusted domain indicates unelevated access in the trusting domain**
	- i.e., a non-administrator in the trusted domain can fully enumerate the trusting domain

---

## SID Filtering

---

## High-Level Trust Attack Strategy

### 1. Recursively Mapping Out the Trusts

[[trusts#Mapping Domain Trusts|Determine your current domain's trusts and then recursively do the same with all of the domains it has a trust relationship with until you've built out a map of trusts.]] Recursion is necessary due to transitivity.

### 2. Enumerate Foreign (Cross-Trust Principal-to-Resource) Relationships

While the configuration of trusts alone has security implications (see [[trusts#Intra-Forest Trusts vs Inter-Forest Trusts]]), trusts have generally been configured for a particular reason: to allow some principal(s) in one domain to interact with resources in another domain. Pay particular attention to these [[trusts#Three Primary Foreign Relationships|foreign relationships]], as they can most likely be abused to pivot across domains.

### 3. Perform Targeted Account Compromise to Reach the Objective

With a map of the trusts and the cross-trust principal-to-resource relationships in hand, perform targeted account compromise of those principals to reach your objective.

---

## Mapping Domain Trusts

There are several methods for mapping domain trusts, each with its own pros and cons.

### 1. Enumerating the [[global-catalog|Global Catalog]]

Enumerating the global catalog allows you to retrieve the internal and external trusts of all domains in the current forest. This method only generates traffic between the executing machine and the current doman's primary domain controller.

- [[powerview#Enumerate Internal External Trusts of all Domains in the Current Forest]]

### 2. Enumerating Each Individual Domain's Domain Controller via LDAP

[[trusts#LDAP Object Class|This LDAP object class]] can be used to enumerate all of a domain's trusts. You can do this recursively for all domain's in the forest and by following transitive relationships.

- [[powerview#Recursively Enumerate Trusts of all Domains of the Current Forest and all Transitive Domains]]
	- Requires network connectivity and a security context capable of issuing LDAP queries to each domain's primary domain controller
- [[bloodhound#Generate a Graph of a Foreign Domain]]
	- Use the `trusts` Collection Method to just collect trust information
	- Requires network connectivity and a security context capable of issuing LDAP queries to each domain's primary domain controller

---

## Three Primary Foreign Relationships

These are the three primary ways that principals in a trusted domain have access to resources in a trusting domain:

1. **Local Groups**: they are a member of local groups on individual machines in the trusting domain
	- i.e.,the local `Administrators` group on a server
	- [[powerview#List All or Retrieve a Specify Local Group on a Local or Remote Computer|PowerView's Get-NetLocalGroupMember]] for manual enumeration
	- [[bloodhound|BloodHound's -CollectionMethod LocalGroup]] does this automatically
2. **Domain Groups**: they are a member of domain groups in the trusting domain
	- i.e., the `Workstation Admins` group
	- [[powerview#List All Users Who are Members of the Current Domain and are in Groups of Foreign Domains|PowerView's Get-DomainForeignUser]]
	- [[powerview#List All Users Who are Members of a Target Domain and are in Groups of Foreign Domains|PowerView's Get-DomainForeignUser with -Domain flag]]
	- [[bloodhound|BloodHound's -CollectionMethod Group]] does this automatically
3. **ACLs**: they are the subject in an ACE of the [[acls|DACL]] of a principal in the trusting domain
	- i.e., `GenericWrite` to the domain controller
	- [[powerview#Retrieve an Object's DACL|PowerView's Get-DomainObjectAcl]] and relevant filtering by the SID for manual enumeration
	- [[bloodhound|BloodHound's -CollectionMethod ACL]] does this automatically

---

## Operational Guidance

Three potential scenarios:

### 1. If you have achieved administrative access to a child domain, you can proceed to achieve administrative access to the forest root

Refer to the [[trusts#Trustpocalypse - SID-Hopping up Intra-Forest Trusts|Trustpocalypse]] section for how.

### 2. If you are currently in a child domain without administrative access and are targeting another domain in the forest

See if there are any instances of the [[trusts#Three Primary Foreign Relationships|three primary exploitable cross-trust relationships]] you can exploit to perform actions in the target domain or another domain in the forest. If you can compromise a single domain in the forest, [[trusts#Trustpocalypse - SID-Hopping up Intra-Forest Trusts|you can compromise the forest root]] and then, the entire forest.

### 3. If you are currently in a domain with or without administrative access and are targeting a domain that isn't in the forest

See if there are any instances of the [[trusts#Three Primary Foreign Relationships|three primary exploitable cross-trust relationships]] you can exploit to perform actions in the target domain or in another domain in the target domain's forest. If you can compromise a single domain in the forest, [[trusts#Trustpocalypse - SID-Hopping up Intra-Forest Trusts|you can compromise the forest root]] and then, the entire forest.

---

## Cross-Domain Interactions & Network Connectivity

When interacting with a service in a trusting domain as a principal from a trusted domain, the principal first makes a [[kerberos|Kerberos]] request to its domain's primary domain controller, who returns a refferal ticket. The principal then uses the referral ticket to interact with the trusting domain's primary domain controller.

Huge implication: to properly enumerate a trusting domain, you must have network connectivity to the trusting domain's primary domain controller.

---

## LDAP Object Class

The `objectClass` for a domain trust object is `trustedDomain`. Thus, if you wanted to query an LDAP server for all its trusts, the query `(objectClass=trustedDomain)` would suffice.

---

## Trustpocalypse - SID-Hopping up Intra-Forest Trusts

In Windows Server 2000, Microsoft added the `sidHistory` attribute to Active Directory user principals. The purpose of this attribute is to ease the process of migrating the principals from one domain to another. The administrator can specify the user's previous SID and all their previous group SIDs in the `sidHistory` attribute.

When a user attempts to access a resource, Active Directory not only evaluates the user's current SID and the SID of their current groups when examining the target object's ACL, but also the SIDs in the user's `sidHistory` attribute. This means that the user effectively has the same level of access as any SID in its `sidHistory` attribute.

A user's `sidHistory` attribute is embedded with its TGTs' [[kerberos#Privilege Attribute Certificate PAC|PAC]] as the `ExtraSids` attribute. Since SID filtering isn't in play for intra-forest communication, any domain in the forest (including the forest root domain) is going to consider the SIDs in the PAC's `ExtraSids` when evaluating a request to a resource.

All of this means that if you're able to compromise a child domain and retrieve its `krbtgt` hash, you can generate a [[golden-ticket|golden ticket]] for the child domain's domain administrator account whose PAC's `ExtraSids` attribute contains the SID of the forest root domain's `Enterprise Admins` account. You can then use this golden ticket to perform administrative actions on any domain in the forest.

Here's how:

- [[mimikatz#Trustpocalypse - Create and Use a Golden Ticket with ExtraSids Set to the SID of Enterprise Admins of the Forest Root Domain|mimikatz]]
- You can also try [[ticketer|impacket-ticketer]] with similar parameters as the above `mimikatz` command (use the `extra-sid` parameter)

---

## References

[Microsoft's How Domain & Forest Trusts Work](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc773178(v=ws.10)?redirectedfrom=MSDN)

[harmj0y's A Guide to Attacking Domain Trusts](http://www.harmj0y.net/blog/redteaming/a-guide-to-attacking-domain-trusts/)
