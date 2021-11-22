# [Lightweight Directory Access Protocol](https://ldap.com/)

> A network protocol for retrieving data organized in a tree.

---

## Extract Everything from an Active Directory Domain

```bash
ldapsearch -LLL -x -h $LDAP_SERVER_HOSTNAME_OR_IP -p $LDAP_PORT [-D '$DISTINGUISHED_NAME_OF_PRINCIPAL_AUTHENTICATING_AS'] [-w $PASSWORD] -b '$DISTINGUISHED_NAME_OF_DOMAIN' ['$LDAP_FILTER'] [$ATTRIBUTE_1] [$ATTRIBUTE_2] [$ATTRIBUTE_N]
```

- `-D`: Omit for anonymous login
	- `$DISTINGUISHED_NAME_OF_PRINCIPAL_AUTHENTICATING_AS`
		- Example: for the domain user account `active.htb\tgihf`, the distinguished name would be `cn=tgihf,dc=active,dc=htb`
- `-w`: Omit for anonymous login
- `$DISTINGUISHED_NAME_OF_DOMAIN` format: `DC=$1ST_SUBDOMAIN,DC=$TLD`
	- Example: for the domain `active.htb`, the distinguished name would be `DC=active,DC=htb`

Also via [[nmap#Anonymously extract data from an LDAP server|nmap]].

---

## Extract Users from an Active Directory Domain

```bash
ldapsearch -LLL -x -h $LDAP_SERVER_HOSTNAME_OR_IP -p $LDAP_PORT [-D $DISTINGUISHED_NAME_OF_PRINCIPAL_AUTHENTICATING_AS] [-w $PASSWORD] -b '$DISTINGUISHED_NAME_OF_DOMAIN' '(&(objectclass=user)(name=*))' [name sAMAccountName description]
```

- `-D`: Omit for anonymous login
	- `$DISTINGUISHED_NAME_OF_PRINCIPAL_AUTHENTICATING_AS`
		- Example: for the domain user account `active.htb\tgihf`, the distinguished name would be `cn=tgihf,dc=active,dc=htb`
- `-w`: Omit for anonymous login
- `$DISTINGUISHED_NAME_OF_DOMAIN` format: `DC=$1ST_SUBDOMAIN,DC=$TLD`
	- Example: for the domain `active.htb`, the distinguished name would be `DC=active,DC=htb`

---

## Extract Computers from an Active Directory Domain

```bash
ldapsearch -LLL -x -h $LDAP_SERVER_HOSTNAME_OR_IP -p $LDAP_PORT [-D $DISTINGUISHED_NAME_OF_PRINCIPAL_AUTHENTICATING_AS] [-w $PASSWORD] -b '$DISTINGUISHED_NAME_OF_DOMAIN' '(&(objectclass=computer)(name=*))' [name sAMAccountName]
```

- `-D`: Omit for anonymous login
	- `$DISTINGUISHED_NAME_OF_PRINCIPAL_AUTHENTICATING_AS`
		- Example: for the domain user account `active.htb\tgihf`, the distinguished name would be `cn=tgihf,dc=active,dc=htb`
- `-w`: Omit for anonymous login
- `$DISTINGUISHED_NAME_OF_DOMAIN` format: `DC=$1ST_SUBDOMAIN,DC=$TLD`
	- Example: for the domain `active.htb`, the distinguished name would be `DC=active,DC=htb`

---

## Extract Groups from an Active Directory Domain

```bash
ldapsearch -LLL -x -h $LDAP_SERVER_HOSTNAME_OR_IP -p $LDAP_PORT [-D $DISTINGUISHED_NAME_OF_PRINCIPAL_AUTHENTICATING_AS] [-w $PASSWORD] -b '$DISTINGUISHED_NAME_OF_DOMAIN' '(&(objectclass=group)(name=*))' [name sAMAccountName]
```

- `-D`: Omit for anonymous login
	- `$DISTINGUISHED_NAME_OF_PRINCIPAL_AUTHENTICATING_AS`
		- Example: for the domain user account `active.htb\tgihf`, the distinguished name would be `cn=tgihf,dc=active,dc=htb`
- `-w`: Omit for anonymous login
- `$DISTINGUISHED_NAME_OF_DOMAIN` format: `DC=$1ST_SUBDOMAIN,DC=$TLD`
	- Example: for the domain `active.htb`, the distinguished name would be `DC=active,DC=htb`

---

## Filter Away Common Active Directory User Attributes

```bash
$OUTPUT_FROM_USERS | grep -v -f attrs.txt
```

where `$OUTPUT_FROM_USERS` is the output from [[ldap#Extract Users from an Active Directory Domain|extracting users from the domain]] and `attrs.txt` is the following:

```txt
accountExpires
badPwdCount
company
whenCreated
department
description
userAccountControl
displayName
division
dn
mail
employeeId
employeeNumber
userAccountControl
mailNickname
msExchHideFromAddressLists
homeMDB
msExchMailboxGUID
msExchRBACPolicyLink
msExchMobileMailboxPolicyLink
msExchMailboxTemplateLink
publicDelegates
proxyAddresses
proxyAddresses
facsimileTelephoneNumber
givenName
memberOf
objectGuid
homeDirectory
homeDrive
wWWHomePage
homePhone
initials
ipPhone
sn
lockoutTime
lockoutTime
userWorkstations
manager
middleName
mobile
whenChanged
info
physicalDeliveryOfficeName
otherFacsimileTelephoneNumber
otherHomePhone
otherIpPhone
otherPager
otherTelephoneNumber
unicodePwd
userAccountControl
pwdLastSet
pwdLastSet
userAccountControl
pager
telephoneNumber
postOfficeBox
primaryGroupID
profilePath
scriptPath
servicePrincipalName
objectSid
userAccountControl
st
streetAddress
title
userAccountControl
userAccountControl
sAMAccountName
userPrincipalName
postalCode
objectClass
uSNCreated
objectGUID
codePage
countryCode
badPasswordTime
logonCount
sAMAccountType
objectCategory
dSCorePropagationData
refldap
cn
uSNChanged
msDS-SupportedEncryptionTypes
```

---

## Resources

[HackTricks's Pentesting LDAP Page](https://book.hacktricks.xyz/pentesting/pentesting-ldap)
