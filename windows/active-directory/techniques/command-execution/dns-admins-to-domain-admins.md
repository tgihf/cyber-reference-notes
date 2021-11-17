# `DnsAdmins` to `Domain Admins`

---

## Description

Windows Active Directory DNS server implementation allows any user in the `DnsAdmins` group (along with any user that has `Write` access to the DNS Server object) to configure the DNS server such that `NT AUTHORITY/SYSTEM` executes the DLL on the DNS server on startup. In situations where the DNS server often runs on the domain controller, this can lead to total domain takeover.

---

## Process

### 1. Generate the DLL

[This Github repository](https://github.com/kazkansouh/DNSAdmin-DLL) has an example Visual Studio project that can be used as a starting point. Modify line 34 in `DNSAdmin-DLL/DNSAdmin-DLL.cpp` to the path (can be UNC) of a text file containing commands to execute, one per line. Build the solution.

### 2. Make the DLL Available

Either via an SMB server that is reachable by the DNS server or upload directly to the DNS server.

### 3. Configure the DNS Service

Configure the DNS Service to run the DLL on startup.

```cmd
dnscmd $DNS_SERVER_FQDN_OR_IP /config /serverlevelplugindll: $PATH_TO_DLL
```

- `$DNS_SERVER_FQDN_OR_IP`: Since this command is generally being executed on the DNS server itself, can be `localhost`
- `$PATH_TO_DLL`: Can be a local or UNC path

### 4. (Optional) Restart the DNS Service

By default, members of the `DnsAdmins` group don't have the privilege to restart the DNS service. Instead, you'll just have to wait until it restarts organically. However, if you do have the permissions:

```cmd
sc.exe [$DNS_SERVER_FQDN_OR_IP] stop dns
sc.exe [$DNS_SERVER_FQDN_OR_IP] start dns
```

- `$DNS_SERVER_FQDN_OR_IP`: Omit if executing on the DNS server itself

This should result in the DNS server executing the DLL, which will cause it to execute each command in the command file specified in the DLL's source code.

---

## References

[Shay Ber's Original Report](https://medium.com/@esnesenon/feature-not-bug-dnsadmin-to-dc-compromise-in-one-line-a0f779b8dc83)

[HackTricks Page of DnsAdmins](https://book.hacktricks.xyz/windows/active-directory-methodology/privileged-accounts-and-token-privileges#dnsadmins)

[iredteam's Walkthrough](https://www.ired.team/offensive-security-experiments/active-directory-kerberos-abuse/from-dnsadmins-to-system-to-domain-compromise)

[Hack the Box's Resolute](https://app.hackthebox.com/machines/Resolute)
