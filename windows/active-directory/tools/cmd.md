# cmd.exe

> Windows' default shell.

---

## Domain Enumeration

### Get the domain name

Must be executed on a domain-joined computer.

```cmd
echo %USERDOMAIN%
```

```cmd
echo %USERDNSDOMAIN%
```

---

### List the domain controllers

Must be executed on a domain-joined computer.

```cmd
nltest /dclist:$DOMAIN
```

```cmd
echo %LOGONSERVER%
```

```cmd
set logonserver
```

```cmd
set log
```

Can only be used on a domain controller:

```cmd
net group "Domain Controllers"
```

---

### List all the domain groups

Must be executed on a domain-joined computer.

```cmd
net groups /domain
```

---

### List all the domain computers

Must be executed on a domain-joined computer.

```cmd
net view /domain
```

---

### List all the domain users

Must be executed on a domain-joined computer.

```cmd
net user /domain
```

---

### Get a particular domain user

Must be executed on a domain-joined computer.

```cmd
net user $USERNAME /domain
```

---

### List all users that belong to the `Administrators` group (includes `Domain Admins`)

Must be executed on a domain-joined computer.

```cmd
net localgroup administrators /domain
```

---

### List all users that are domain administrators

Must be executed on a domain-joined computer.

```cmd
net group "Domain Admins" /domain
```

---

### Get the domain's password & lockout policy

Must be executed on a domain-joined computer.

```cmd
net accounts /domain
```

---

## Domain Actions

### Change a domain user's password

```cmd
net user $USERNAME $PASSWORD /domain
```

### Add user to domain group

```cmd
net group $GROUPNAME $USERNAME /add /domain
```
