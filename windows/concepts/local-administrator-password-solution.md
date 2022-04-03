# Local Administrator Password Solution (LAPS)

> Local Administrator Password Solution (LAPS) provides management of local account passwords of domain joined computers. Passwords are generated randomly, changed regularly, stored in Active Directory (AD), and protected by ACL, so only eligible users can read it or request its reset.

---

## LAPS Indicators

When LAPS is enabled on a domain, 2 new LDAP attributes appear on computer objects of the domain:

- `ms-msc-AdmPwd`: the plaintext password for the local administrator account for the computer
- `ms-msc-AdmPwdExpirationTime`: the time at which the above password will expire and need to be changed by LAPS (happens automatically)

---

## Abusing LAPS Misconfigurations - Reading Local Administrator Passwords

LAPS passwords are added to domain computer objects in LDAP and protected via [[dacls-aces|ACLs]]. However, sometimes ACLs are misconfigured.

If you have access to a principal that is capable of reading the LAPS password of a particular computer (`ReadLAPSPassword` edge in [[bloodhound|BloodHound]]), follow one of the techniques [here](https://www.hackingarticles.in/credential-dumpinglaps/#:~:text=LAPS%20simplifies%20password%20management%20while,password%20combination%20on%20their%20computers.) to retrieve that password. Then, login as the local administrator account on that computer with the retrieved password.

- [[crackmapexec#Attempt to Read LAPS Passwords|crackmapexec]]

See [Hack the Box Timelapse](https://github.com/tgihf/private-writeups/blob/main/htb/boxes/timelapse/timelapse.md) for an example.

---

## References

[Microsoft - Local Administrator Password Solution (LAPS)](https://www.microsoft.com/en-us/download/details.aspx?id=46899)

[HackTricks - Windows Local Privilege Escalation - LAPS](https://book.hacktricks.xyz/windows/windows-local-privilege-escalation#laps)

[Hacking Articles - Credential Dumping - LAPS](https://www.hackingarticles.in/credential-dumpinglaps/#:~:text=LAPS%20simplifies%20password%20management%20while,password%20combination%20on%20their%20computers.)

[Hack the Box - Timelapse](https://github.com/tgihf/private-writeups/blob/main/htb/boxes/timelapse/timelapse.md)
