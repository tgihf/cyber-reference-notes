# Interacting with Active Directory via `cmd`

---

## Get the domain name

Must be executed on a domain-joined computer.

```cmd
echo %USERDOMAIN%
```

```cmd
echo %USERDNSDOMAIN%
```

---

## List the domain controllers

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

[[net#List the domain controllers]]

---

## List all the domain groups

[[net#List all the domain groups]]

---

## List all the domain computers

[[net#List all the domain computers]]

---

## List all the domain users

[[net#List all the domain users]]

---

## Get a particular domain user

[[net#Get a particular domain user]]

---

## List all users that belong to the `Administrators` group (includes `Domain Admins`)

[[net#List all users that belong to the Administrators group includes Domain Admins]]

---

## List all users that are domain administrators

[[net#List all users that are domain administrators]]

---

## Get the domain's password & lockout policy

[[net#Get the domain's password lockout policy]]

---

## Create a new domain user

[[net#Create a new domain user]]

---

## Change a domain user's password

[[net#Change a domain user's password]]

---

## Add user to domain group

[[net#Add user to domain group]]
