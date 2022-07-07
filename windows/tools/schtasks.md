# schtasks

> [[windows/tools/cmd/cmd|cmd]] command for viewing and configuring scheduled tasks on local or remote Windows systems.

---

## List all Scheduled Tasks

```cmd
schtasks
```

---

## Query a Particular Scheduled Task

```cmd
schtasks /query /tn "$FULL_PATH_TASK_NAME" /v
```

---

## Schedule a Local Task

```cmd
schtasks /create /sc $FREQUENCY /mo $MODIFIER /tn "$FULL_PATH_TASK_NAME" /tr $PATH_TO_FILE_TO_RUN [/ru $RUN_AS_USER_USERNAME] [/rp $RUN_AS_USER_PASSWORD]
```

---

## Schedule a Remote Task

```cmd
schtasks /create /sc $FREQUENCY /mo $MODIFIER /tn "$FULL_PATH_TASK_NAME" /tr $PATH_TO_FILE_TO_RUN [/ru $RUN_AS_USER_USERNAME] [/rp $RUN_AS_USER_PASSWORD] /s $REMOTE_FQDN_OR_IP
```

---

## Change a Local Task

```cmd
schtasks /change /tn $FULL_PATH_TASK_NAME 
```

---

## Possible `$FREQUENCY` and `$MODIFIER` Values

Possible `$FREQUENCY` values and their corresponding `$MODIFIER` values.

| `$FREQUENCY` | `$MODIFIER` |
| --- | --- | 
| MINUTE | 1 - 1439 |
| HOURLY | 1 - 23 |
| DAILY | 1 - 365 |
| WEEKLY | 1 - 52 |
| ONCE | N/A |
| ONSTART | N/A |
| ONLOGON | N/A |
| ONIDLE | N/A |
| MONTHLY | 1 - 12 OR FIRST, SECOND, THIRD, FOURTH, LAST, LASTDAY |
| ONEVENT | XPath event query string |

---

## Possible `$RUN_AS_USER_USERNAME` Values

To run as `NT AUTHORITY/SYSTEM`, valid values of `$RUN_AS_USER` are `""`, `"NT AUTHORITY/SYSTEM"`, and `"SYSTEM"`.
