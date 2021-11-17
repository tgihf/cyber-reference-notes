# [Lightweight Directory Access Protocol](https://ldap.com/)

> A network protocol for retrieving data organized in a tree.

---

## Extract Everything from an Active Directory Domain

```bash
ldapsearch -LLL -x -h $LDAP_SERVER_HOSTNAME_OR_IP -p $LDAP_PORT [-D $DOMAIN/$USERNAME] [-w $PASSWORD] -b '$DISTINGUISHED_NAME_OF_DOMAIN' ['$LDAP_FILTER'] [$ATTRIBUTE_1] [$ATTRIBUTE_2] [$ATTRIBUTE_N]
```

- `-D`: Omit for anonymous login
- `-w`: Omit for anonymous login
- `$DISTINGUISHED_NAME_OF_DOMAIN` format: `DC=$1ST_SUBDOMAIN,DC=$TLD`
	- Example: for the domain `active.htb`, the distinguished name would be `DC=active,DC=htb`

Also via [[nmap#Anonymously extract data from an LDAP server|nmap]].

---

## Extract Users from an Active Directory Domain

```bash
ldapsearch -LLL -x -h $LDAP_SERVER_HOSTNAME_OR_IP -p $LDAP_PORT [-D $DOMAIN/$USERNAME] [-w $PASSWORD] -b '$DISTINGUISHED_NAME_OF_DOMAIN' '(&(objectclass=user)(name=*))' name sAMAccountName description
```

- `-D`: Omit for anonymous login
- `-w`: Omit for anonymous login
- `$DISTINGUISHED_NAME_OF_DOMAIN` format: `DC=$1ST_SUBDOMAIN,DC=$TLD`
	- Example: for the domain `active.htb`, the distinguished name would be `DC=active,DC=htb`

---

## Extract Computers from an Active Directory Domain

```bash
ldapsearch -LLL -x -h $LDAP_SERVER_HOSTNAME_OR_IP -p $LDAP_PORT [-D $DOMAIN/$USERNAME] [-w $PASSWORD] -b '$DISTINGUISHED_NAME_OF_DOMAIN' '(&(objectclass=computer)(name=*))' name sAMAccountName
```

- `-D`: Omit for anonymous login
- `-w`: Omit for anonymous login
- `$DISTINGUISHED_NAME_OF_DOMAIN` format: `DC=$1ST_SUBDOMAIN,DC=$TLD`
	- Example: for the domain `active.htb`, the distinguished name would be `DC=active,DC=htb`

---

## Extract Groups from an Active Directory Domain

```bash
ldapsearch -LLL -x -h $LDAP_SERVER_HOSTNAME_OR_IP -p $LDAP_PORT [-D $DOMAIN/$USERNAME] [-w $PASSWORD] -b '$DISTINGUISHED_NAME_OF_DOMAIN' '(&(objectclass=group)(name=*))' name sAMAccountName operatingsystem
```

- `-D`: Omit for anonymous login
- `-w`: Omit for anonymous login
- `$DISTINGUISHED_NAME_OF_DOMAIN` format: `DC=$1ST_SUBDOMAIN,DC=$TLD`
	- Example: for the domain `active.htb`, the distinguished name would be `DC=active,DC=htb`

---

## Resources

[HackTricks's Pentesting LDAP Page](https://book.hacktricks.xyz/pentesting/pentesting-ldap)
