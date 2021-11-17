# Impacket's smbexec.py

Used for remote command execution on a target machine via SMB with an administrator credential.

## Gain command shell

```bash
smbexec.py [$DOMAIN/]$USERNAME[:$PASSWORD]@$TARGET_IP [-hashes $LMHASH:$NTLMHASH]
```
