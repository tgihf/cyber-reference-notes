# Backing Up & Dumping SAM Registry File

> With the right level of permission, a user can backup a local copy of a Windows machine's SAM registry file and parse that file to dump the machine's users' password hashes.

---

## Required Privileges

The user must have the `SeBackupPrivilege` and the `SeRestorePrivilege` (default permissions of the `Backup Operators` AD group). Checkable via `whoami /priv` or `whoami /all`.

The user must also have access to the target machine. Note, if you have these privileges and access to an Active Directory domain controller, try [[backing-up-and-dumping-ntds.dit|backing up and dumping ntds.dit]] instead.

---

## Backing Up & Dumping SAM

Copy the `SAM` and `SYSTEM` registry hive files.

```powershell
$ reg save hklm\sam $OUTPUT_PATH_TO_SAM_REGISTRY_FILE
$ reg save hklm\system $OUTPUT_PATH_TO_SYSTEM_REGISTRY_FILE
```

Transfer the files back to the attacking machine and parse them there using [[secretsdump#Dump a local SAM registry file requires SYSTEM registry hive file|impacket]] or [[pypykatz#Parse a SAM Registry File|pypykatz]].

---

## References

[Hacking Articles's Walkthrough](https://www.hackingarticles.in/windows-privilege-escalation-sebackupprivilege/)