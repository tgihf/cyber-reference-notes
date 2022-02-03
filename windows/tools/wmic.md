# [wmic](https://docs.microsoft.com/en-us/windows/win32/wmisdk/wmic)

> `wmic` has long been the standard tool for interacting with [[windows-management-instrumentation|Windows Management Instrumentation (WMI)]]. Querying operating system information, installed antivirus, domain information, users, groups, enabling remote desktop, and even remote command execution are all possible through [[windows-management-instrumentation|WMI]] and thus, `wmic`. `wmic` has recently been replaced by PowerShell for [[windows-management-instrumentation|WMI]].

---

## General Query Syntax

```cmd
wmic [/node:$REMOTE_HOST] $CIM_TYPE $CONDITIONS $ACTION $OPTIONS
```

---

## Query Operating System Information

```cmd
wmic [/node:$REMOTE_HOST] os get caption,version
```

To obtain a full list of possible attributes, run `wmic os get /?`.

---

## Query Installed Updates

```cmd
wmic [/node:$REMOTE_HOST] qfe list brief
```

---

## Query Installed Antivirus

```cmd
wmic [/node:$REMOTE_HOST] /namespace:\\root\securitycenter2 path antivirusproduct
```

---

## Query Local Users

```cmd
wmic [/node:$REMOTE_HOST] useraccount list full
```

---

## Query Local Groups

```cmd
wmic [/node:$REMOTE_HOST] group list full
```

---

## Execute a Command

```cmd
wmic [/node:$REMOTE_HOST] process call create "cmd.exe /c '$COMMAND'"
```

---

## Enable Remote Desktop

```cmd
wmic [/node:$REMOTE_HOST] rdtoggle where AllowTSConnections="0" call SetAllowTSConnections "1"
```

---

## Query Attached Drives

```cmd
wmic logicaldisk get caption,description,providername
```

---

## Query Services

```cmd
wmic service get name,startname,pathname
```

---

## Domain Enumeration

### Query Domain & Domain Controller(s)

```cmd
wmic [/node:$REMOTE_HOST] NTDOMAIN GET DomainControllerAddress,DomainControllerName,DomainName
```

---

### Query Domain Computers

```cmd
wmic /NAMESPACE:\\root\directory\ldap PATH ds_computer GET ds_samaccountname,ds_dnshostname
```

---

### Query Domain Users

```cmd
wmic /NAMESPACE:\\root\directory\ldap PATH ds_user GET ds_samaccountname,ds_name,ds_description
```

---

### Query Domain Groups

```cmd
wmic /NAMESPACE:\\root\directory\ldap PATH ds_group GET ds_samaccountname
```

---

### Query Domain Group Members

```cmd
wmic /NAMESPACE:\\root\directory\ldap PATH ds_group where "ds_samaccountname='$GROUP_SAM_ACCOUNT_NAME'" get ds_member
```
