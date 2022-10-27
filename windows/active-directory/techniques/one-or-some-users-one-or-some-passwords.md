# Active Directory Hacking Techniques when You Have One or Some Credentials

---

## 1. Enumeration

- [ ] [[powerview#Get-NetDomain|Domain]]
- [ ] [[powerview#Get-DomainComputer|Computers]]
- [ ] [[powerview#Get-DomainUser|Users]]
- [ ] [[powerview#Get-DomainGroup|Groups]]
- [ ] [[powerview#Get-DomainOU|OUs]]
- [ ] [[group-policy#Enumerate Group Policy Objects|GPOs]]
- [ ] [[dacls-aces#Retrieve an Object's DACL requires domain user credentials|Discretionary Access Control Lists]]
- [ ] [[mssql#Enumerate a Domain's MSSQL Servers|MSSQL Servers]]
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
- [ ] DACL Misconfigurations
	- [ ] [[dacls-aces#Permissions of Interest|Exploit vulnerable permissions]]
- [ ] Delegation Misconfigurations
	- [ ] [[unconstrained-delegation|Hunt for exploitable instances of unconstrained delegation]]
	- [ ] [[constrained-delegation|Hunt for exploitable instances of constrained delegation]]
	- [ ] [[resource-based-constrained-delegation|Hunt for exploitable instances of resource-based constrained delegation]]]
- [ ] Abuse accessible MSSQL Servers and their linked servers
	- [ ] [[mssql#Capture MSSQL Server's NetNTLMv2 Hash|Capture and crack accessible MSSQL servers' NetNTLMv2 hashes]]
		- [ ] This can also be adapted for linked servers
	- [ ] [[mssql#Execute Operating System Commands on an MSSQL Server|Execute operating system commands on accessible MSSQL servers]]
	- [ ] [[mssql#Command Execution Methodology on MSSQL Server's Linked Servers|Execute operating system commands on accessible MSSQL servers' linked servers]]
- [ ] GPO Misconfigurations
	- [ ] If an owned principal has permission, [[group-policy#Group Policy#Create GPO and Link to OU|create a new GPO and link it to an OU that contains a target principal]]
	- [ ] If an owned principal has permission, [[group-policy#Modify Existing GPO|modify an existing GPO]] that affects an OU that contains a target principal
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

- [ ] [[adcs#Leveraging a Certificate for Persistence|Generate an ADCS certificate for a principal]]
- [ ] [[dcsync#Add DCSync Privileges to a Principal|Add DCSync privilege to a principal you control]]
- [ ] [[golden-ticket|If you've compromised a domain administrator's account, you can dump the domain controller's hashes to obtain krbtgt's hash and create a golden ticket]]
- [ ] [[group-policy|Create and link or modifying existing GPO to allow persistent access]]
- [ ] [[silver-ticket|If you've compromised a principal, create a silver ticket for that account]]
