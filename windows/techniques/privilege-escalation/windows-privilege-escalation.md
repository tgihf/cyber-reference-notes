# Windows Privilege Escalation

The process of escalating privileges on a Linux machine involves careful enumeration. Work through the following steps for consistency and thoroughness.

---

## Windows Privilege Escalation Process

### 1. Situational Awareness

See [[windows-situational-awareness|here]].

### Credential Hunting

See [[windows-credential-hunting|here]].

### `AlwaysInstallElevated` Exploitation

See [[always-install-elevated-privesc|here]].

### Registry Run Key Exploitation

See [[run-key-privesc|here]].

### Startup Folder Exploitation

See [[startup-folder-privesc|here]].

### Token Privilege Exploitation

See [[token-privilege-exploitation|here]].

### Windows Subsystem for Linux (WSL) Exploitation

See [[wsl-privesc|here]].

### Service Misconfiguration Exploitation

See [[service-misconfigurations|here]].

### Automated Privilege Escalation Enumeration

**Enumeration**

- [[winpeas|winpeas (.NET 4.0 binary or batch script)]]
- [SeatBelt.exe](https://github.com/GhostPack/Seatbelt)
- [[sharpup|SharpUp.exe]]
- [[powerup|PowerUp.ps1]]

**Exploit Suggestion**

- [[windows-exploit-suggester|Windows Exploit Suggester]]
- Meterpreter's exploit suggester
- [Watson.exe](https://github.com/rasta-mouse/Watson)

### Windows Kernel Exploits

See [[windows-kernel-exploits|here]].

---

## Elevate from a Local Administrator to `NT AUTHORITY\SYSTEM`

- [[get-system|Get System]]

---

## 2. Local Privilege Escalation Checks

Automated: [[powerup|PowerUp]] or [[sharpup|SharpUp]]

### 2.1 [[service-misconfigurations|Service Misconfigurations]]

### 2.2 Scheduled Tasks

```cmd
schtasks /query /V
```

- [[powershell-scheduled-tasks]]

### 2.3 AlwaysInstallElevated

`AlwaysInstallElevated` is a feature that ensures `.msi` programs are always installed as `NT AUTHORITY/SYSTEM`.

If the entry `AlwaysInstallElevated` at `HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer` and `HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer` is equal to 1, then the feature is enabled.

### 2.4 Unattended Installation Files

Unattended installation files are files used to configure a fresh installation of Windows in a particular way. These often contain credentials. Common unattended installation file paths:

```txt
C:\Windows\sysprep\sysprep.xml
C:\Windows\sysprep\sysprep.inf
C:\Windows\sysprep.inf
C:\Windows\Panther\Unattended.xml
C:\Windows\Panther\Unattend.xml
C:\Windows\Panther\Unattend\Unattend.xml
C:\Windows\Panther\Unattend\Unattended.xml
C:\Windows\System32\Sysprep\unattend.xml
C:\Windows\System32\Sysprep\unattended.xml
C:\unattend.txt
C:\unattend.inf
```

### 2.5 [[autologon|AutoLogon]]

Perhaps you can find the credential of a higher privileged user?

### 2.6 [[run-keys|Registry Run Keys]]

Perhaps you can write to the system's or another user's registry run key? Perhaps you can write to one of the binaries that the system or another user's registry run key points to? Perhaps the run key binary path is unquoted and has spaces? Perhaps you can hijack one of the run key binary's DLLs?

### 2.7 Startup Folders

Perhaps you can write to the system's or another user's startup folder?

### 2.8 Check Installed Programs

Note any non-standard programs in `C:\Windows\Program Files` and `C:\Windows\Program Files (x86)`. Research privilege escalation vectors associated with these non-standard programs. These programs may also have related services, scheduled tasks, or registry entries.

### 2.9 Check Local Groups

- [[net#List the local groups]]
- [[powershell#Query Local Groups]]

### 2.10 Check Current User's Temporary Directory

Look in `C:\Users\$USERNAME\AppData\Local\Temp`.

### 2.11 Check Environment Variables

```cmd
set
```

### 2.12 Check for Anything Interesting in the [[wmic#Query Attached Drives|Attached Drives]]

### 2.13 Check the Various [[powershell-logging|PowerShell Logging Sources]]

### ?. Try Operating System Exploits

---

## References

[PayloadsAllTheThings - Windows Privilege Escalation Methodology & Resources](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Windows%20-%20Privilege%20Escalation.md)

[absolomb's Security Blog - Windows Privilege Escalation Guide](https://www.absolomb.com/2018-01-26-Windows-Privilege-Escalation-Guide/)

[sushant747 - Privilege Escalation Windows](https://sushant747.gitbooks.io/total-oscp-guide/content/privilege_escalation_windows.html)

[Conda's Privilege Escalation Maps](https://github.com/C0nd4/OSCP-Priv-Esc)

[Fuzzy Security - Windows Privilege Escalation Fundamentals](https://www.fuzzysecurity.com/tutorials/16.html)
