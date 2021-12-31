# Local Security Authority Subsystem Service

The Local Security Authority Subsystem Service (LSASS) process in the Windows operating system that is responsible for enforcing the local system's security policy. LSASS is responsible for authenticating users attempting to log in to the system and for creating and granting [[access-tokens|access tokens]].

After a user logs in, the system generates and stores a variety of credential material in the LSASS process memory. Administrative and SYSTEM-level users are capable of [[dumping-lass|dumping the LSASS process memory]] and extracting the credential material within.

---

## References

[LSASS Wikipedia](https://en.wikipedia.org/wiki/Local_Security_Authority_Subsystem_Service#:~:text=Local%20Security%20Authority%20Subsystem%20Service%20(LSASS)%20is%20a%20process%20in,changes%2C%20and%20creates%20access%20tokens.)
