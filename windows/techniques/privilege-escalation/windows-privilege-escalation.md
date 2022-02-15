# Windows Privilege Escalation

The process of escalating privileges on a Linux machine involves careful enumeration. Work through the following steps for consistency and thoroughness.

---

## Windows Privilege Escalation Process

### 1. Situational Awareness

See [[windows-situational-awareness|here]].

### 2. Credential Hunting

See [[windows-credential-hunting|here]].

### 3. `AlwaysInstallElevated` Exploitation

See [[always-install-elevated-privesc|here]].

### 4. Registry Run Key Exploitation

See [[run-key-privesc|here]].

### 5. Startup Folder Exploitation

See [[startup-folder-privesc|here]].

### 6. PowerShell Logging Sources

See [[powershell-logging|here]].

### 7. Token Privilege Exploitation

See [[token-privilege-exploitation|here]].

### 8. Windows Subsystem for Linux (WSL) Exploitation

See [[wsl-privesc|here]].

### 9. Service Misconfiguration Exploitation

See [[service-misconfigurations|here]].

### 10. Scheduled Task Misconfiguration Exploitation

Similar methodology to service misconfiguration exploitation.

```cmd
schtasks /query /V
```

- [[powershell-scheduled-tasks]]

### 11. Installed Applications

Are there any known local privilege escalation vulnerabilities in the installed applications?

### 12. Automated Privilege Escalation Enumeration

**Enumeration**

- [[winpeas|winpeas (.NET 4.0 binary or batch script)]]
- [SeatBelt.exe](https://github.com/GhostPack/Seatbelt)
- [[sharpup|SharpUp.exe]]
- [[powerup|PowerUp.ps1]]

**Exploit Suggestion**

- [[windows-exploit-suggester|Windows Exploit Suggester]]
- Meterpreter's exploit suggester
- [Watson.exe](https://github.com/rasta-mouse/Watson)

### 13. Kernel Exploits

See [[windows-kernel-exploits|here]].

---

## Elevate from a Local Administrator to `NT AUTHORITY\SYSTEM`

- [[get-system|Get System]]

---

## References

[PayloadsAllTheThings - Windows Privilege Escalation Methodology & Resources](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Windows%20-%20Privilege%20Escalation.md)

[absolomb's Security Blog - Windows Privilege Escalation Guide](https://www.absolomb.com/2018-01-26-Windows-Privilege-Escalation-Guide/)

[sushant747 - Privilege Escalation Windows](https://sushant747.gitbooks.io/total-oscp-guide/content/privilege_escalation_windows.html)

[Conda's Privilege Escalation Maps](https://github.com/C0nd4/OSCP-Priv-Esc)

[Fuzzy Security - Windows Privilege Escalation Fundamentals](https://www.fuzzysecurity.com/tutorials/16.html)
