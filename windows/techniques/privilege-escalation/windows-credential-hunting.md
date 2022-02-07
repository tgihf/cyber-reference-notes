# Credential Hunting

---

## Credential Hunting Process

1. [[windows-credential-hunting#View Credentials Stored in Windows Credential Manager|View credentials stored in Windows Credential Manager]].
1. Search for passwords in [[windows-credential-hunting#Common Files that May Contain Passwords|files that often contain them]].
2. Search for passwords in [[windows-credential-hunting#Common Registry Entries that May Contain Passwords|registry entries that often contain them]].
3. Search for variations of the word "password" in files ([[windows-credential-hunting#Search for Variations of the Word Password|here]]).

---

## View Credentials Stored in Windows Credential Manager

[[cmdkey#Display a List of All Stored Usernames Credentials|List credentials stored in Windows Credential Manager]]. If there are any stored,  [[runas#Run Command as Another User with Credential Saved in Windows Credential Manager|leverage them to run commands]].

---

## Common Files that May Contain Passwords

Be on the look out for encoded (i.e., base64) passwords in these files as well.

```txt
c:\sysprep.inf
c:\sysprep\sysprep.xml
c:\unattend.xml
%WINDIR%\Panther\Unattend\Unattended.xml
%WINDIR%\Panther\Unattended.xml

dir c:\*vnc.ini /s /b
dir c:\*ultravnc.ini /s /b 
dir c:\ /s /b | findstr /si *vnc.ini
```

---

## Common Registry Entries that May Contain Passwords

- [[autologon|Autologons registry key]]

```batch
# VNC
reg query "HKCU\Software\ORL\WinVNC3\Password"

# SNMP Paramters
reg query "HKLM\SYSTEM\Current\ControlSet\Services\SNMP"

# Putty
reg query "HKCU\Software\SimonTatham\PuTTY\Sessions"
```

---

## Search for Variations of the Word Password

In files with `.txt`, `.xml`, and `.ini` extensions:

```batch
findstr /si password *.txt
findstr /si password *.xml
findstr /si password *.ini
```

In all files:

```batch
findstr /spin "password" *.*
```

In the registry:

```batch
# Search for password in registry
reg query HKLM /f password /t REG_SZ /s
reg query HKCU /f password /t REG_SZ /s
```

---

## Reference

[Sushant747 - Privilege Escalation Windows - Cleartext Passwords](https://sushant747.gitbooks.io/total-oscp-guide/content/privilege_escalation_windows.html)
