# Group Policy

> A policy is a set of rules or configurations that apply to one or more organizational units (OUs). They are used to administer a forest or domain at scale.

---

## Example Policies

* Disable Windows Defender
  * Disables windows defender across all machine on the domain
* Digitally Sign Communication (Always)
  * Can disable or enable SMB signing on the domain controller

---

## Enumerate Group Policy Objects

- Primary
	- [[powerview#List All Principals Capable of Creating New GPOs]]
	- [[powerview#List All Principals Capable of Linking GPOs to Particular OUs]]
	- [[powerview#List All Principals that can Modify Existing GPOs]]
- Auxiliary
	- [[powerview#List All Computers in a Particular OU]]
	- [[powerview#Resolve GPO ObjectDN to Display Name]]

---

## Create GPO and Link to OU

See [[rsat#Create New GPO and Link to OU|here]].

---

## Modify Existing GPO

- To update arbitrary registry values on affected computers, see [[rsat#Modify GPO to Write New Key into OU's Computer's Registries|here]]
- To schedule a task on affected computers, see [[sharp-gpo-abuse#Modify Existing GPO to Schedule Task on All Affected Computers|here]]
- For other actions, see [[sharp-gpo-abuse|here]]
