# Active Directory Lateral Movement

---

## WinRM

Create a WinRM session on a remote host under the current or a new user context. Execute shell commands within this session.

- [[powershell-remote-session|PowerShell]]
- [[cobalt-strike-lateral-movement#WinRM|Cobalt Strike]]

### Kibana Queries

- Egress connection to WinRM

```kql
event.module : "sysmon" and event.type : "connection" and network.direction : "egress" and (destination.port : "5985" or destination.port : "5986")
```

- Spawning of new WinRM connection process on remote host (`wsmprovhost.exe` with `-Embedding` parameter)

```kql
event.module : sysmon and event.type : process_start and process.command_line : "C:\\Windows\\system32\\wsmprovhost.exe -Embedding"
```

If PowerShell logging is enabled, the command that was executed can be retrieved from the process above:

```kql
event.module : "powershell" and process.pid : $PID
```

### Kibana Rules

- [Incoming Execution via WinRM Remote Shell](https://www.elastic.co/guide/en/security/current/incoming-execution-via-winrm-remote-shell.html)

### References

[WinRM for Lateral Movement - Red Team Experiments](https://www.ired.team/offensive-security/lateral-movement/t1028-winrm-for-lateral-movement)

---

## Distributed Component Object Model (DCOM)

Instantiate a [[component-object-model|COM class]] capable of executing arbitrary code/command(s) on a remote host under the current or a new user context. Leverage the object to execute the code/command(s).

- Manual PowerShell: See **Red Team Experiments** link below for how to use the `MMC20.Application` COM class for lateral movement
- [PowerShell Module](https://github.com/EmpireProject/Empire/blob/master/data/module_source/lateral_movement/Invoke-DCOM.ps1)
	- Capable of leveraging *several* different COM classes (see code for which ones)

### Kibana Rules

- [Incoming DCOM Lateral Movement with MMC](https://www.elastic.co/guide/en/security/current/incoming-dcom-lateral-movement-with-mmc.html)
- [Incoming DCOM Lateral Movement with ShellBrowserWindow or ShellWindows](https://www.elastic.co/guide/en/security/current/incoming-dcom-lateral-movement-with-shellbrowserwindow-or-shellwindows.html)
- [Incoming DCOM Lateral Movement via MSHTA](https://www.elastic.co/guide/en/security/current/incoming-dcom-lateral-movement-via-mshta.html)

### References

[DCOM for Lateral Movement - Red Team Experiments](https://www.ired.team/offensive-security/lateral-movement/t1175-distributed-component-object-model)

---

## Windows Management Instrumentation (WMI)

Create a new `process` object in the remote host's [[windows-management-instrumentation|WMI]] repository with the specified target executable path and command line arguments.

- [[wmic]]
- [[cobalt-strike-lateral-movement#WMI|Cobalt Strike]]

### Kibana Rules

- [Suspicious Cmd Execution via WMI](https://www.elastic.co/guide/en/security/current/suspicious-cmd-execution-via-wmi.html)
- [WMI Incoming Lateral Movement](https://www.elastic.co/guide/en/security/current/wmi-incoming-lateral-movement.html)
- [Suspicious WMI Image Load from MS Office](https://www.elastic.co/guide/en/security/current/suspicious-wmi-image-load-from-ms-office.html)
- [Windows Script Interpreter Executing Process via WMI](https://www.elastic.co/guide/en/security/current/windows-script-interpreter-executing-process-via-wmi.html)

### References

[WMI for Lateral Movement - Red Team Experiments](https://www.ired.team/offensive-security/lateral-movement/t1047-wmi-for-lateral-movement)

---

## PsExec

Create and run a service on the remote host that points to a staged service binary payload or a stageless payload.

- [[cobalt-strike-lateral-movement#PsExec|Cobalt Strike]]
- [[psexec|impacket]]

### Kibana Queries

- Creation of service executable

```kql
event.module : sysmon and event.type : creation and event.category : file and file.extension : exe and file.directory : "$DIRECTORY"
```

- Creation of service

```ksql
event.provider : "Service Control Manager" and message : "A service was installed in the system.*"
```

### Kibana Rules

- [Suspicious Process Execution via Renamed PsExec Executable](https://www.elastic.co/guide/en/security/current/suspicious-process-execution-via-renamed-psexec-executable.html)
- [PsExec Network Connection](https://www.elastic.co/guide/en/security/current/psexec-network-connection.html)

### References

- [PsExec for Lateral Movement - Red Team Experiments](https://www.ired.team/offensive-security/lateral-movement/lateral-movement-with-psexec)

---

## References

[Red Team Adventures](https://riccardoancarani.github.io/2019-10-04-lateral-movement-megaprimer/#introduction)
