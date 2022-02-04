# Situational Awareness

---

## System Eumeration

### Operating System Information

Via the command prompt:

```cmd
systeminfo
```

Via WMIC:

- [[wmic#Query Operating System Information]]

Via PowerShell:

- [[powershell#Query Operating System Version from NET Systen Environment Library]]

### Installed Updates (Hotfixes)

Via the command prompt:

```batch
systeminfo
```

Via WMIC:

- [[wmic#Query Installed Updates]]

Via PowerShell:

- [[powershell#Query Installed Updates via WMI]]

### Attached Drives

Via WMIC:

- [[wmic#Query Attached Drives]]

### Running Processes

Via the command prompt:

- [[tasklist#List Currently Running Processes]]

Via PowerShell:

- [[powershell#List Currently Running Processes]]

### .NET Versions

[[reg#Retrieve Registry Key|Query the registry key]] `"HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP"`.

### PowerShell Version (if applicable)

- [[powershell#Get PowerShell Version]]

---

## User Enumeration

### Current Access Token's Attributes (SID, Groups, & Privileges)

More information about Windows access tokens [[access-tokens|here]].

```cmd
whoami /all
```

### Users

Via command prompt:

- [[net#List the local users]]
- [[net#View a Particular Local User]]

Via PowerShell:

- [[powershell#Query Local Users]]
- [[powershell#Query a Particular Local User]]

### Groups

Via command prompt:

- [[net#List the local groups]]
- [[net#View a particular local group]]

Via PowerShell:

- [[powershell#Query Local Groups]]
- [[powershell#Query a Particular Local Group]]

---

## Network Enumeration

### Network Interfaces

Via command prompt:

```cmd
ipconfig /all
```

Via PowerShell:

- [[powershell#Query Network Adapters]]

### Routing Table

Via command prompt:

```cmd
route print
```

Via PowerShell:

- [[powershell#Query Routing Table]]

### ARP Cache

Via command prompt:

```cmd
arp -a
```

Via PowerShell:

- [[powershell#Query ARP Cache]]

### Current Network Listeners & Connections

Via command prompt:

```cmd
netstat -ano
```

Via PowerShell:

- [[powershell#Query Network Listeners Connections]]

### Offered Shares

Via command prompt:

- [[net#View the Current Machine's Offered Shares]]

Via PowerShell:

- [[powershell#Query SMB Shares]]

---

## Defensive Countermeasure Enumeration

### Installed Antivirus

Via command prompt:

- [[sc#Query for Existence of Windows Defender Service]]

Via WMIC:

- [[wmic#Query Installed Antivirus]]

Via PowerShell:

- [[powershell#Query Installed Antivirus via WMI]]

### AppLocker

Via PowerShell:

- [[powershell#Query AppLocker Policies]]

### Firewall Settings

Via command prompt:

```batch
netsh advfirewall firewall dump
```

```batch
netsh firewall show state
```

```batch
netsh firewall show config
```

Via PowerShell:

- [[powershell#Query Firewall Rules]]
