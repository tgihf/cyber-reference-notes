# Windows Registry

---

## Registry Hive

A registry hive is a logical group of keys, subkeys, and values in the registry that has a set of supporting files loaded into memory when the operating system is started or a user logs in.

There are seven standard registry hives, each with its own corresponding file that contains its data.

| Hive | File Path |
| --- | --- |
| HKEY_CURRENT_CONFIG | `C:\Windows\System32\config\SYSTEM` |
| HKEY_CURRENT_USER | `C:\Users\$CURRENT_LOGGED_ON_USERNAME\NTUSER.DAT` |
| HKEY_LOCAL_MACHINE\\SAM | `C:\Windows\System32\config\SAM` |
| HKEY_LOCAL_MACHINE\\SECURITY | `C:\Windows\System32\config\SECURITY` |
| HKEY_LOCAL_MACHINE\\SOFTWARE | `C:\Windows\System32\config\SOFTWARE` |
| HKEY_LOCAL_MACHINE\\SYSTEM | `C:\Windows\System32\config\SYSTEM` |
| HKEY_USERS\\.DEFAULT | `C:\Windows\System32\config\DEFAULT` & `C:\Users\$USERNAME\NTUSER.DAT` |

---

## Interacting with the Registry

- [[powershell-registry|PowerShell]]
- [[reg|cmd]]

---

## Reading a Registry Key Entry

- [[powershell-registry#Retrieve Registry Key Entry|PowerShell]]
- [[reg#Retrieve Registry Key Entry|cmd]]