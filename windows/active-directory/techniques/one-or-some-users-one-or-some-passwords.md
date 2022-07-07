# Active Directory Hacking Techniques when You Have One or Some Credentials

---

## Enumeration

### Gather Domain Information

- From a Linux machine:
	- [[pywerview]]
	- [[windapsearch]]
	- [[ldapsearch]]
- From a domain-joined Windows machine via `C#`
	- [[sharpview]]
	- [[ADSearch]]
- From a domain-joined Windows machine via `PowerShell`
	- [[powershell-active-directory-module|PowerShell Active Directory Module (if available)]]
	- [[powerview|PowerView]]
- From a domain-joined Windows machine via `cmd`
	- [[cmd-active-directory|cmd.exe]]
	- [[dsquery]]
	- [[wmic#Domain Enumeration|wmic]]

---

### Graph object relationships in a domain

- [[bloodhound]]
	- There is a `Python` collector for Linux and a `PowerShell` and `C#` collector for Windows.

---

### List ASREP-Roastable Users

See [[ASREP-roasting#Gather users who have kerberos Kerberos Pre-Authentication Kerberos pre-authentication disabled and thus are vulnerable to ASREP Roasting requires domain credentials|here]].

---

## Exploitation

### ASREP-Roast vulnerable domain users

See [[ASREP-roasting|here]].

---

### Kerberoast vulnerable domain users

See [[kerberoasting|here]].

---

### Pass a domain credential(s) to a target(s) to check for various types of access

See [[crackmapexec|here]].

---

### Attempt to escalate privileges to local administrator on a machine in the domain so you can dump hashes

See [[windows-privilege-escalation|here]].

---

### Hunt for exploitable instances of unconstrained delegation

See [[unconstrained-delegation|here]].

---

### Hunt for exploitable instances of traditional constrained delegation

See [[constrained-delegation|here]].

---

### Hunt for exploitable instances of resource-based constrained delegation

See [[resource-based-constrained-delegation|here]].

---

### Exploit the "Printer Bug" to force a computer with the Spooler Service enabled to authenticate to an attacker controlled host

See [[printer-bug|here]].

---

### Exploit "Print Nightmare" for local privilege escalation or privileged remote code execution on computers with the Spooler Service Enabled

See [[CVE-2021-34527-print-nightmare|here]].

---

### Check domain shares for reversible credentials in group policy preference files

See [[gpp-cpassword-leak|here]].

---

### If the Target's OS is Windows Server 2003 - 2012 R2, exploit MS14-068

See [[ms14-068|here]].

---

### Abuse LAPS Misconfiguration

See [[local-administrator-password-solution#Abusing LAPS Misconfigurations - Reading Local Administrator Passwords|here]].

---

## Persistence

### If you have compromised a principal, create a silver ticket for that account.

See [[silver-ticket|here]].

---

### If you have compromised the domain administrator's account, you can dump the domain controller's hashes to obtain `krbtgt`'s hash and create a golden ticket.

See [[golden-ticket|here]].
