# Active Directory Hacking Techniques with One or Some Credential Pairs

---

## Enumeration

### Gather Domain Information from a Linux machine

- [[pywerview]]
- [[windapsearch]]

---

### Gather domain information from a domain-joined Windows machine via `C#`

- [[sharpview]]

---

### Gather domain information from a domain-joined Windows machine via `PowerShell`

- [[powershell-active-directory-module|PowerShell Active Directory Module (if available)]]
- [[powerview|PowerView]]

---

### Gather domain information from a domain-joined Windows machine via `cmd`

- [[cmd#Domain Enumeration|cmd.exe]]

---

### Graph object relationships in a domain

There is a `Python` collector for Linux and a `PowerShell` and `C#` collector for Windows.

- [[bloodhound]]

---

### [[ASREP-roasting#Gather users who have kerberos Kerberos Pre-Authentication Kerberos pre-authentication disabled and thus are vulnerable to ASREP Roasting requires domain credentials|Gather domain users who have Kerberos pre-authentication disabled and thus are vulnerable to ASREP Roasting]]

---

## Exploitation

### [[ASREP-roasting|ASREP Roast Vulnerable Domain Users]]

---

### [[kerberoasting|Kerberoast Vulnerable Domain Users]]

---

### If you have compromised (or [[kerberoasting|Kerberoasted]]) a machine service account or a user service account, create a [[silver-ticket|Silver Ticket]] for that account. 

---

### If you have compromised the domain administrator's account, you can [[dumping-hashes|dump the domain controller's hashes]] to obtain `krbtgt`'s hash and create a [[golden-ticket|golden ticket]].

---

### [[crackmapexec#Pass a domain credential to a target to check for access|Determine if the credential(s) you have is a local administrator on any machines in the domain]].

---

### Attempt to escalate privileges to local administrator on a machine in the domain so you can dump hashes.

---

### Hunt for Exploitable Instances of [[unconstrained-delegation|Unconstrained Delegation]]

---

### Hunt for Exploitable Instances of [[constrained-delegation|Traditional Constrained Delegation]]

---

### Hunt for Exploitable Instances of [[resource-based-constrained-delegation|Resource-Based Constrained Delegation]]

---

### [[spooler-service-abuse|Force Computers with the Spooler Service Enabled to Authenticate to an Attacker-Controlled Host]]

---

### [[gpp-cpassword-leak|Check Domain Shares for Reversible Credentials in Group Policy Preference Files]]

---

### If the Target's OS is Windows Server 2003 - 2012 R2, exploit [[ms14-068|MS14-068]]
