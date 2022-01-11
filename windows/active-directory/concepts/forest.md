# Forest

A collection of one or more domain trees in Active Directory Domain Services (ADDS).

---

## Trees

- A hierarchy of domains in Active Directory Domain Services (ADDS).

## Domains

- Used to group and manage objects

## Organizational Units (OUs)

- Containers for groups, computers, users, printers, and other OUs

## Trust

- Allows users to access resources in other domains
- Cross-domain in nature
- All domains in a forest trust all other domains in the forest
- Trusts can extend outside a forest

## Types of Trusts

- Directional: the trust direction flows from trusting domain to the trusted domain
- Transitive: the trust relationship is extended beyond a two-domain trust to include other trusted domains

## Objects

- Users, groups, computers, printers, shares

## Domain Services

- DNS
- LLMNR
- NBT-NS
- IPv6

## Domain Schema

- Rules for object creation

---

## References

[Microsoft's How Domain & Forest Trusts Work](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc773178(v=ws.10)?redirectedfrom=MSDN)
