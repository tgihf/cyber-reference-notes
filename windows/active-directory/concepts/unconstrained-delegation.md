# Unconstrained Delegation

Unconstrained delegation is the oldest form of Active Directory [[delegation]], dating back to Windows Server 2000.

It allows an Active Directory principal (think user or computer) to forward the credentials of any domain user that authenticates to it to any service in the domain.

Its *implementation* is where the vulnerability lies. To be capable of forwarding the service tickets of any domain user that authenticates to it to any service in the domain, the computer extracts the user account's TGT from the service ticket (a copy of the TGT is stored in the service ticket when unconstrained delegation is in play) and saves it in memory in case it needs to forward it on behalf of the user account in the future.

If an attacker has local administrator access to the computer, they can extract these TGTs at will and forward them to impersonate the corresponding user accounts across the domain.

This can be taken a step further by the "printer bug," a feature within the Windows Print System Remote Protocol that allows a host to query another host, asking for an update on a print job. The target host will respond by authenticating to the host that initiated a request via a service ticket, which contains the TGT while unconstrained delegation is in play.

Thus, if an attacker is a local administrator on a computer configured with unconstrained delegation, they can use the "printer bug" to coerce a domain controller into authenticating into their controlled machine and then extract the domain administrator's TGT from the machine's memory, granting them unfettered access across the domain.

---

## Caveat

A principal with unconstrained delegation can impersonate any domain principal to any SPNs in the domain **EXCEPT FOR** users in the `Protected Users` security group or whose unconstrained delegation privileges have been otherwise revoked.

---

## Configure a Computer with Unconstrained Delegation

### Server Manager

On the domain controller and in the `Server Manager`'s dashboard, open `Tools` --> `Active Directory Users and Computers` and open the target computer's `Properties`. Under the `Delegation` tab, select `Trust this computer for delegation to any service (Kerberos only)`.

![[Pasted image 20211028181650.png]]

Click `Apply` and `OK`.

### PowerShell

From the domain controller:

```bash
Set-ADUser -Identity $USERNAME -TrustedForDelegation $true
```

---

## Indicator that a Domain Computer is Configured with Unconstrained Delegation

Its object representation's `userAccountControl` attribute contains the value `ADS_UF_TRUSTED_FOR_DELEGATION` (or just `TRUSTED_FOR_DELEGATION`).

---

## Determine which Computers & Users in the Domain are Configured with Unconstrained Delegation

- From a Linux machine:
	- [[pywerview#Gather Computers Users Configured with unconstrained-delegation Unconstrained Delegation|pywerview]]
- From a domain-joined Windows machine (in the context of a domain user)
	- [[sharpview#Gather Computers Configured with unconstrained-delegation Unconstrained Delegation|SharpView]]
	- [[powerview#Gather Computers Users Configured with unconstrained-delegation Unconstrained Delegation|PowerView]]
	- [[powershell-active-directory-module#Gather Computers Users Configured with unconstrained-delegation Unconstrained Delegation|PowerShell Active Directory Module]]

---

## Watch for and Extract TGTs from Memory at a Particular Interval

From a domain-joined Windows machine configured with unconstrained delegation and in the context of `NT AUTHORITY/SYSTEM`:

- [[windows/active-directory/tools/rubeus#Listen for and Extract TGTs from Memory at a Particular Interval Exploiting unconstrained-delegation Unconstrained Delegation|Rubeus (C#)]]
- [[c2-frameworks/covenant/tasks/Rubeus|Covenant's Rubeus Task]]

Combine with [[unconstrained-delegation#Exploit the Printer Bug to Coerce a Domain Controller into Authenticating to a Compromised Unconstrained Delegation Computer|abusing the "Printer Bug" to coerce a domain controller into authenticating to the compromised computer configured with unconstrained delegation]] to steal `krbtgt`'s TGT.

Use `krbtgt`'s TGT to [[secretsdump#Dump NTDS dit from domain controller with a Kerberos ticket|dump all the domain's credentials]].


---

## Exploit the "Printer Bug" to Coerce a Domain Controller into Authenticating to a Compromised Unconstrained Delegation Computer

- On a domain-joined Windows computer (in the context of a domain user):
	- [SpoolSample.exe](https://github.com/leechristensen/SpoolSample/tree/master/SpoolSample) (`C#`)
- From a Linux machine (with domain user credentials)
	- [[krbrelayx#Coerce any domain computer to authenticate to a particular FQDN requires domain user credentials|krbrelayx]]

---

## Abuse Unconstrained Delegation & the "Printer Bug" to Coerce a Domain Controller to Connect to the Attacker's Host & Steal its TGT

Original post [here](https://dirkjanm.io/krbrelayx-unconstrained-delegation-abuse-toolkit/). Another helpful walkthrough [here](http://blog.redxorblue.com/2019/12/no-shells-required-using-impacket-to.html).

Relies heavily on the [krbrelayx toolkit](https://github.com/dirkjanm/krbrelayx).

Unconstrained delegation is generally exploited by gaining administrative access to a computer configured with unconstrained delegation, elevating to `NT AUTHORITY/SYSTEM`, [[unconstrained-delegation#Watch for and Extract TGTs from Memory at a Particular Interval|watching memory for any TGTs]], [[unconstrained-delegation#Exploit the Printer Bug to Coerce a Domain Controller into Authenticating to a Compromised Unconstrained Delegation Computer|exploiting the "Printer Bug" to steal `krbtgt`'s TGT]], and then [[secretsdump#Dump NTDS dit from domain controller with a Kerberos ticket|using that TGT to dump the domain's hashes]].

The following method achieves the same effect, but doesn't rely on executing code and examining memory on the remote system. Instead, it coerces the domain controller into authenticating to an attacker-controlled host that it *thinks* is the computer configured with unconstrained delegation. As a result, the DC hands the attacker a TGS (encrypted with a key derived from the compromised unconstrained delegation account, which the attacker will have) that contains `krbtgt`'s TGT. The TGS is decrypted and the TGT is extracted and used for unfettered access across the domain.

The process requires four steps:

1. Gain administrative access on the computer configured with unconstrained delegation and [[dumping-hashes|dump its hashes]] to get the computer account's NTLM hash and Kerberos keys.
2. Add a new `HOST` SPN to the computer account configured with unconstrained delegation tying it to a new FQDN on the domain (i.e., `HOST/tgihf.marvel.test`).
3. Add a DNS record in [[active-directory-integrated-domain-name-service|ADIDNS]] that points the new FQDN to the IP address of an attacker controlled machine (i.e., `tgihf.marvel.test` --> `192.168.1.200`).
4. Start `krbrelayx` on the attacker-controlled machine to mimick the computer configured with unconstrained delegation to any computer that attempts to authenticate to it.
5. Trigger the "Printer Bug" on the domain controller to coerce it into authenticating to the attacker controlled computer via the FQDN (i.e., `tgihf.marvel.test`).
6. The domain controller will authenticate to the attacker controlled computer and  hand over its service ticket, encrypted with a key derived from the unconstrained delegation computer account's password. `krbrelayx` will use that password to decrypt the service ticket and save the `krbtgt`'s TGT to disk.

### 1. Dumping the Unconstrained Delegation Computer's NTLM Hash & Kerberos Keys

You'll need these to execute the rest of the attack.

Doing this requires administrative access to the computer configured with unconstrained delegation: [[dumping-hashes|dump a compromised computer's hashes & Kerberos keys (LSA Secrets)]].

![[Pasted image 20211029220456.png]]

### 2. Add a New `Host` SPN to the Unconstrained Delegation Computer Account

See [[krbrelayx#Add a new Host SPN to a compromised unconstrained delegation computer or user account|krbrelayx's addspn.py]].

### 3. Add a DNS A Record that Maps the FQDN from the New `Host` SPN to an Attacker-Controlled IP Address

See [[krbrelayx#Add a new DNS record to ADIDNS that maps the new Host SPN in the unconstrained delegation computer account to an attacker-controlled IP address|krbrelayx's dnstool.py]].

### 4. Trigger the "Print Bug" & Coerce the Domain Controller to Authenticate to the Attacker-Controlled Computer that is Impersonating the Unconstrained Delegation Computer, Steal `krbtgt`'s TGT, and Dump the Domain's Hashes

See [[krbrelayx#Coerce the domain controller into authenticating to the attacker controlled machine as if it was the unconstrained delegation computer and steal krbtgt 's TGT|krbrelayx's krbrelayx.py & printerbug.py]].

---

## References

[Specter Ops's "The Unintended Risks of Trusting Active Directory" DerbyCon Talk](https://www.youtube.com/watch?v=KbTTDICqCa8)
