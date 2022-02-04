# Get System

> `getsystem` is a Meterpreter command that implements three different techniques for **elevating from local administrator to `NT AUTHORITY\SYSTEM`**. It now has a PowerShell and C# implementation, among others.

---

## Techniques

**Technique 1** creates a named pipe from Meterpreter. It also creates and runs a service that runs `cmd.exe /c echo “some data” >\\.\pipe\[random pipe here]`. When the spawned `cmd.exe` connects to Meterpreter’s named pipe, Meterpreter has the opportunity to impersonate that security context. Impersonation of clients is a named pipes feature. The context of the service is SYSTEM, so when you impersonate it, you become SYSTEM.

**Technique 2** is like technique 1. It creates a named pipe and impersonates the security context of the first client to connect to it. To create a client with the SYSTEM user context, this technique drops a DLL to disk (!) and schedules `rundll32.exe` as a service to run the DLL as SYSTEM. The DLL connects to the named pipe and that’s it. Look at `elevate_via_service_namedpipe2` in Meterpreter’s source to see this technique.

As the help information states, **this technique drops a file to disk**. This is an opportunity for an anti-virus product to catch you. If you’re worried about anti-virus or leaving forensic evidence, avoid technique 2.
	
**Technique 3** is a little different. This technique assumes you have `SeDebug` privilege—something `getprivs` can help with. It loops through all open services to find one that is running as SYSTEM and that you have permissions to inject into. It uses reflective DLL injection to run its `elevator.dll` in the memory space of the service it finds. This technique also passes the current thread id (from Meterpreter) to `elevator.dll`. When run, elevator.dll gets the SYSTEM token, opens the primary thread in Meterpreter, and tries to apply the SYSTEM token to it.

**This technique’s implementation limits itself to x86 environments only**. On the bright side, it does not require spawning a new process and it takes place entirely in memory.

---

## Implementations

- [Meterpreter](https://docs.rapid7.com/metasploit/meterpreter-getsystem/)
- [PowerShell](https://powersploit.readthedocs.io/en/latest/Privesc/Get-System/)
- [C#](https://github.com/py7hagoras/GetSystem)

---

## References

[Cobalt Strike - What happens when I type getsystem?](https://www.cobaltstrike.com/blog/what-happens-when-i-type-getsystem/)

[py7hagoras - C# GetSystem](https://github.com/py7hagoras/GetSystem)

[PowerSploit - PowerShell Get-System](https://powersploit.readthedocs.io/en/latest/Privesc/Get-System/)
