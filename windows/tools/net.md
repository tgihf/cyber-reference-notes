# net

> [[windows/tools/cmd/cmd|cmd]] tool for managing network resources.

---

## Local Users

### List the local users

```cmd
net user
```

### Create a new local user

```cmd
net user $USERNAME $PASSWORD /add
```

---

## Local Groups

### List the local groups

```cmd
net localgroup
```

### Create a new local group

```cmd
net localgroup $GROUPNAME /add
```

---

## Domain Controllers

### List the domain controllers

```cmd
net group "Domain Controllers"
```

---

## Domain Groups

### List all the domain groups

```cmd
net groups /domain
```

---

## Domain Computers

### List all the domain computers

```cmd
net view /domain
```

---

## Domain Users

### List all the domain users

```cmd
net user /domain
```

### List all users that belong to the `Administrators` group (includes `Domain Admins`)

```cmd
net localgroup administrators /domain
```

### List all users that are domain administrators

```cmd
net group "Domain Admins" /domain
```

### Get a particular domain user

```cmd
net user $USERNAME /domain
```

### Create a new domain user

```cmd
net user $USERNAME $PASSWORD /add /domain
```

### Change a domain user's password

```cmd
net user $USERNAME $PASSWORD /domain
```

### Add user to domain group

```cmd
net group $GROUPNAME $USERNAME /add /domain
```

---

## Domain's Password & Lockout Policy

Must be executed on a domain-joined computer.

```cmd
net accounts /domain
```
