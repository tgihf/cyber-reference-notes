# [tasklist](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/tasklist)

> `cmd` command for listing the currently running processes on a Windows system.

---

## General Syntax

```cmd
tasklist /V [/S $REMOTE_HOST] [/U $USERNAME] [/P $PASSWORD] /FI "$FILTER"
```

Possible filters:

| Filter Name | Valid Operators | Valid Value(s) |
| --- | --- | --- |
| STATUS |eq, ne | RUNNING, SUSPENDED, NOT RESPONDING, UNKNOWN |
| IMAGENAME | eq, ne | Image name |
| PID | eq, ne, gt, lt, ge, le | PID value |
| SESSION | eq, ne, gt, lt, ge, le | Session number |
| SESSIONNAME | eq, ne | Session name |
| CPUTIME |eq, ne, gt, lt, ge, le | CPU time in the format of hh:mm:ss. hh - hours, mm - minutes, ss - seconds |
| MEMUSAGE | eq, ne, gt, lt, ge, le | Memory usage in KB
| USERNAME | eq, ne | User name in \[domain\\\]user format |
| SERVICES | eq, ne | Service name |
| WINDOWTITLE | eq, ne | Window title |
| MODULES| eq, ne | DLL name |

---

## List Currently Running Processes

```cmd
tasklist /V
```
