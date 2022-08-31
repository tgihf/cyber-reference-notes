# Active Directory Hacking Techniques when You Have One or Some Credentials

---

## 1. Enumeration

- [ ] [[powerview#Get-NetDomain|Domain]]
- [ ] [[powerview#Get-DomainComputer|Computers]]
- [ ] [[powerview#Get-DomainUser|Users]]
- [ ] [[powerview#Get-DomainGroup|Groups]]
- [ ] [[powerview#Get-DomainOU|OUs]]
- [ ] [[group-policy#Enumerate Group Policy Objects|GPOs]]
- [ ] [[forest#Enumeration|Forest]]
- [ ] [[trusts#Mapping Domain Trusts|Trusts]]

### Enumeration Tools

- [ ] Graph Based: [[bloodhound]]
	- There is a `Python` collector for Linux and a `PowerShell` and `C#` collector for Windows.
- [ ]  Object based:
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

## 2. Hunting for Accesses, Misconfigurations, and Vulnerabilities

- [ ] For each possessed credential:
	- [ ] [[crackmapexec|Pass a domain credential(s) to a target(s) to check for various types of access]]
		- [ ] If unelevated, [[windows-privilege-escalation|attempt to elevate privileges to local administrator and dump hashes]]
- [ ] Kerberos Misconfigurations
	- [ ] [[ASREP-roasting|ASREP Roast vulnerable domain users]]
	- [ ] [[kerberoasting|Kerberoast vulnerable domain users]]
- [ ] Delegation Misconfigurations
	- [ ] [[unconstrained-delegation|Hunt for exploitable instances of unconstrained delegation]]
	- [ ] [[constrained-delegation|Hunt for exploitable instances of constrained delegation]]
	- [ ] [[resource-based-constrained-delegation|Hunt for exploitable instances of resource-based constrained delegation]]]
- [ ] Abuse LAPS
	- [ ] [[local-administrator-password-solution|Abuse LAPS misconfiguration]]
- [ ] Known Vulnerabilities & Misconfigurations
	- [ ] [[printer-bug|Exploit the Printer Bug to force a computer with the Spooler Service enabled to authenticate to an attacker controlled host]]
	- [ ] [[CVE-2021-34527-print-nightmare|Exploit Print Nightmare for local privilege escalation or privileged remote code execution on computers with the Spooler Service enabled]]
	- [ ] [[gpp-cpassword-leak|Check for reversible credentials in group policy preference (GPP) files]]
	- [ ] [[ms14-068|If the target's OS is Windows Server 2033 - 1012 R2, exploit MS14-068]]
- [ ] Exploiting Trusts
	- [ ] [[trusts#High-Level Trust Attack Strategy]]


---

## 3. Establish Persistence

- [ ] [[silver-ticket|If you've compromised a principal, create a silver ticket for that account]]
- [ ] [[golden-ticket|If you've compromised a domain administrator's account, you can dump the domain controller's hashes to obtain krbtgt's hash and create a golden ticket]]
- [ ] [[adcs#Leveraging a Certificate for Persistence|Generate an ADCS certificate for a principal]]
- [ ] [[group-policy|Create and link or modifying existing GPO to allow persistent access]]
