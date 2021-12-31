# Windows Autologon

Windows Autologon is a feature that, when enabled, allows someone with physical access to a computer to automatically log into a user account without knowing the account's password. This is achieved by **storing the password in cleartext in the registry, readable by any authenticated user**.

The registry key is `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon`. The username is in the entry `DefaultUserName` and the password is in `DefaultPassword`. The entry `AutoAdminLogon` must be set to `1` for this feature to work. If the computer is joined to a domain, the entry `DefaultDomainName` must contain the FQDN of the domain for this feature to work.

---

## References

- [Microsoft Technet](https://docs.microsoft.com/en-us/troubleshoot/windows-server/user-profiles-and-logon/turn-on-automatic-logo)
