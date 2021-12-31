# [SharpUp](https://github.com/GhostPack/SharpUp)

> C# port of [[powerup|PowerUp's]] most common enumeration checks. No weaponization functions have been implemented yet.

---

## SharpUp's Audit Mode

SharpUp's Audit Mode performs the local privilege escalation checks regardless of whether the current process is of high [[integrity-levels|integrity]] or if the current user is a local administrator.

---

## SharpUp's Possible Local Privilege Escalation Checks

```txt
AlwaysInstallElevated
CachedGPPPassword
DomainGPPPassword
HijackablePaths
McAfeeSitelistFiles
ModifiableServiceBinaries
ModifiableServiceRegistryKeys
ModifiableServices
RegistryAutoLogons
RegistryAutoruns
TokenPrivileges
UnattendedInstallFiles
UnquotedServicePath
```

---

## Run All Local Privilege Escalation Checks in Audit Mode

```cmd
SharpUp.exe audit
```

---

## 	Run a Particular Local Privilege Escalation Check in Audit Mode

```cmd
SharpUp.exe audit $CHECK
```

---

## Run a Particular Local Privilege Escalation Check in non-Audit Mode

```cmd
SharpUp.exe $CHECK
```

---

## Check for Modifiable Services

```cmd
SharpUp.exe [audit] ModifiableServices
```

---

## Check for Modifiable Service Binaries

```cmd
SharpUp.exe [audit] ModifiableServiceBinaries
```

---

## Check for Unquoted Service Binary Paths

```cmd
SharpUp.exe [audit] UnquotedServicePath
```

---

## Check for Modifiable Service Registry Keys

```cmd
SharpUp.exe [audit] ModifiableServiceRegistryKeys
```

---

## Check for Hijackable DLLs

```cmd
SharpUp.exe [audit] HijackablePaths
```
