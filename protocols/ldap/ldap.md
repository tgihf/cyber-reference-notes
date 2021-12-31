# [Lightweight Directory Access Protocol](https://ldap.com/)

> A network protocol for retrieving data organized in a tree.

---

## Check if Credentials Grant LDAP Access

[[crackmapexec#General Syntax Pass a credential s to a target s to check for access]]

---

## Extract Everything from an Active Directory Domain

- From Linux:
	- [[ldapsearch#Extract Everything from an Active Directory Domain|ldapsearch]]
	- [[nmap#Anonymously extract data from an LDAP server|nmap]]

---

## Extract Users from an Active Directory Domain

- From Linux:
	- [[ldapsearch#Extract Users from an Active Directory Domain|ldapsearch]]

---

## Extract Computers from an Active Directory Domain

- From Linux:
	- [[ldapsearch#Extract Computers from an Active Directory Domain|ldapsearch]]

---

## Extract Groups from an Active Directory Domain

- From Linux:
	- [[ldapsearch#Extract Groups from an Active Directory Domain|ldapsearch]]

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
