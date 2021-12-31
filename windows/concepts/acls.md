# Windows Access Control Lists (ACLs)

> An access control list (ACL) is an ordered list of access control entries (ACEs) that define the protections that apply to a Windows object and its properties. Each ACE specifies a **security principal** and a **set of access rights** that are allowed, denied, or audited for that security principal. An object's ACLs are set by its owner.

---

## Two Types of ACLs

1. Discretionary Access Control List (DACL)
	- Specifies **principals** that are **allowed** or **denied** certain **access rights**
2. System Access Control List (SACL)
	- Specifies what **types of accesses** from what **principals** are **logged** in the Security Event Log
	
---

## How ACLs Are Enforced

When a user attempts to access an object, Windows will compare the object's security descriptor (which contains its DACL) to the user's [[access-tokens|access token]] to determine if the user is allowed to perform the action it is attempting to perform.

---

## View an Object's DACL

- [[icacls]]
- [[powershell-acls#View an Object's DACL|PowerShell]]
- In `File Explorer`, navigate to the file's `Properties` -> `Security` tab. Click `Advanced` -> `Permissions` for the inherited ACLs.

---

## View an Object's SACL

- [[powershell-acls#View an Object's SACL|PowerShell]]
- In `File Explorer`, navigate to the file's `Properties` -> `Security` tab. Click `Advanced` -> `Auditing`.
