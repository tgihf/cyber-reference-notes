# Windows Integrity Levels

> From Windows Vista and onward, all objects in Windows have an integrity level. One object can only **modify** another object if the other object has an equivalent or lower integrity level, even if the object has full ownership of the other.

---

## Integrity Levels

From lowest to highest:

- **Untrusted**: processes that are logged on anonymously (i.e., Chrome).
- **Low**: default integrity level for processes that interact with the Internet (i.e., Internet Explorer Protected Mode). These processes can't write to the registry.
- **Medium**: default integrity level for all objects. If no integrity level is specified on an object, it has this level of integrity.
- **High**: integrity level of all processes initiated as an **Administrator** (i.e., "Run as Administrator")
- **System**: integrity level of all system- and kernel-level processes and core Windows services
- **Installer**: integrity level of the Windows installer

---

## Check the Current User's Integrity Level

```cmd
whoami /all | findstr "Level"
```

---

## Determine the Integrity Level of a File System Object

```cmd
icacls $PATH_TO_FILE_OR_FOLDER
```

The integrity level line will look something like `Mandatory Label\High Mandatory Level:(NW)`. If you don't see a line like this, it has a `Medium` integrity level.

You can view the same information in `File Explorer` by viewing the file or folder's `Properties` > `Security` tab.

---

## Integrity Level of an Executable

An executable runs with its integrity level. For example, if an executable file has a `Low` integrity level, it will run with a `Low` integrity level.

---

## References

[HackTricks](https://book.hacktricks.xyz/windows/windows-local-privilege-escalation/integrity-levels)
