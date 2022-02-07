# Registry Run Key Privilege Escalation

---

## Process

1. For each of the system's and the users' [[run-keys|run keys]]:
	- Can you write to the registry entry and point it to a binary you control?
	- Can you write to the binary the registry entry points at?
	- Does the binary have an unquoted file path with spaces?
	- Can you DDL hijack the binary?
