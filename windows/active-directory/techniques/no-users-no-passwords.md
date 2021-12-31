# Active Directory Hacking Techniques with No Users & No Passwords

---

## Enumeration

### Discover & Attack Hosts in the Network

Discover hosts and their open ports with [[nmap]]. Enumerate and exploit any exposed, vulnerable services.

---

### Check for null or guest access to SMB shares

Use `smbmap` to check for [[smbmap#List SMB shares of TARGET via null session|null]] or [[smbmap#List SMB shares of TARGET via guest session|guest]] access.

Use `smbclient` to check for [[smbclient#Connect to and browse anonymous SMB share SHARE on TARGET|null]] or [[smbclient#Connect to and browse SMB share SHARE on TARGET with guest session|guest]] access.

---

### [[ldap|Attempt to Anonymously Enumerate the DC's Exposed LDAP Port]]

---

### Gather Credentials by Impersonating Services

- [[llmnr-poisoning#LLMNR Poisoning Responder|LLMNR Poisoning]]
- [[dns-takeover-via-ipv6#DNS Takeover via IPv6|DNS Takeover via IPv6]]

---

### Enumerate Users

When a client sends a `KRB_AS_REQ` request to the KDC **without a [[kerberos#Kerberos Pre-Authentication|pre-authentication]] encrypted timestamp** and **with an invalid username**, the KDC will respond with the error code `KRB5KDC_ERR_C_PRINCIPAL_UNKNOWN`.

However, the same request but **with a valid username** will cause the KDC to respond with either a `KRB_AS_REP` message containing a valid TGT or the error code `KRB5KDC_ERR_PREAUTH_REQUIRED`, depending on whether the user is configured to require [[kerberos#Kerberos Pre-Authentication|Kerberos pre-authentication]].

An attacker can exploit this behavior to determine valid users on the domain.

Use [[kerbrute#Enumerate valid domain usernames via Kerberos|kerbrute]] for this.

---

## Exploit Domain-Joined SQL Server

If you have SQL command execution on a Microsoft SQL Server that is joined to the domain, you can [[mssql#Enumerate SQL Server Logins|enumerate SQL server logins]] and [[mssql#Enumerate Domain Principals|enumerate domain principals]].
