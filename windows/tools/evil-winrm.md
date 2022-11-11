# [evil-winrm](https://github.com/Hackplayers/evil-winrm)

> A Ruby tool for controlling a Windows target through WinRM.

---

## Display `evil-winrm`-Specific Commands that Can be Executed within a Session

```powershell
*Evil-WinRM* PS > menu
```

---

## Control a Windows target with username and password

```bash
evil-winrm -i $TARGET -u [$DOMAIN\\]$USERNAME -p $PASSWORD
```

---

## Pass an NTLM hash and control a Windows target

```bash
evil-winrm -i $TARGET -u [$DOMAIN\\]$USERNAME -H $NTLM_HASH
```

---

## Log in with SSL Certificate & Private Key

```bash
evil-winrm -i $TARGET -u [$DOMAIN\\]$USERNAME --ssl -c $PATH_TO_CERTIFICATE -k $PATH_TO_PRIVATE_KEY
```

---

## Login in via Kerberos

```bash
KRB5CCNAME=$PATH_TO_CCACHE evil-winrm -i $TARGET -r $DOMAIN
```

- `$PATH_TO_CCACHE`: See [[using-kerberos-tickets|here]] (note this link is for `impacket` tools but `evil-winrm` leverages the same technique)

For `-r $DOMAIN`, note the help description: `-r, --realm DOMAIN               Kerberos auth, it has to be set also in /etc/krb5.conf file using this format -> CONTOSO.COM = { kdc = fooserver.contoso.com }`. This will be set under the `[realms]` header in `/etc/krb5.conf` in multiple lines, for example:

```txt
[realms]
...
TARGET.LOCAL = {
	kdc = dc.target.local
}
...
```

