# Registry Run Keys

The `Run` and `RunOnce` keys in the Windows registry cause programs to run whenever a user logs in. Each key can contain multiple entries, and each entry's `Name` is a description string without spaces and each entry's `Value` is a command line.

The entries of the `Run` key will remain in the registry until manually deleted. On the other hand, the entries of the `RunOnce` key are deleted from the registry just *before* the command line is run unless the command line is prefixed with `!`, in which case it will be deleted from the registry just *after* the command line is run. Thus, the `RunOnce` key is not a very effective key for the sake of persistence. `Run` is preferable.

By default, these keys are ignored when the computer is started in Safe Mode. However, if the value of an entry of the `RunOnce` key is prefixed with an asterisk (`*`), then the command line will still be ran even in Safe Mode.

The registry run keys are:

- `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`
- `HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce`
- `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`
- `HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce`

[[registry#Interacting with the Registry|How to interact with the registry]]

References:

- [MITRE ATT&CK](https://attack.mitre.org/techniques/T1547/001/)
- [Microsoft Windows App Development](https://docs.microsoft.com/en-us/windows/win32/setupapi/run-and-runonce-registry-keys)
