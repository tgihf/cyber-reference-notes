# Dumping Hashes on a Windows Machine

> With local administrator and NT AUTHORITY/SYSTEM access to a Windows machine, it is possible to dump password hashes of all logged in users. These can be cracked or passed around the environment for further access.

---

## Remotely Dump Secrets from a Linux Machine

- Pretty much everything (local SAM hashes, cached domain login info, LSA secrets, local computer hashes, DPAPI_SYSTEM, etc.)
	- [[secretsdump#Remotely dump local SAM hashes cached domain logon information LSA secrets local computer hashes MACHINE ACC and DPAPI_SYSTEM|impacket-secretsdump]]
- SAM
	- [[crackmapexec#Remotely dump SAM hashes|crackmapexec]]
- LSA Secrets
	- [[crackmapexec#Remotely dump LSA secrets|crackmapexec]]
