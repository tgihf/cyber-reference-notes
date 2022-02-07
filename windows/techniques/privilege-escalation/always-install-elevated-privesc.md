# `AlwaysInstallElevated` Privilege Escalation

`AlwaysInstallElevated` is a feature that ensures `.msi` programs are always installed as `NT AUTHORITY/SYSTEM`.

If the entry `AlwaysInstallElevated` at `HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer` and `HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer` is equal to 1, then the feature is enabled.
