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
