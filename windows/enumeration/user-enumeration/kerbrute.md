# [kerbrute](https://github.com/ropnop/kerbrute) - *A tool for bruteforcing and enumerating valid Active Directory accounts through Kerberos pre-authentication*

## Enumerate valid domain usernames via Kerberos

* Enumerates usernames by sending TGT requests with no pre-authentication. As a result, doesn't cause any login failures or lock out accounts.
* If Kerberos logging is enabled, this generates event ID [4768](https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/event.aspx?eventID=4768).

```bash
kerbrute userenum -d <DNS domain name> --dc <domain controller (DNS hostname/ip)> <username file>
```
