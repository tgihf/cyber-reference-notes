# [pywerview](https://github.com/the-useless-one/pywerview)

> A partial rewrite of PowerSploit's [[powerview|PowerView]] in Python for Linux users. Queries the domain controller via LDAP to enumerate the domain.

---

## get-netdomaincontroller

Lists all the domain controllers in the network.

```bash
pywerview get-netdomaincontroller -w $DOMAIN -u $USER [-p $PASSWORD|--hashes $LMHASH$:NTHASH] --dc-ip $DOMAIN_CONTROLLER_HOSTNAME_OR_IP -d $DOMAIN_TO_QUERY
```

On Windows: [[powerview#Get-NetDomainController|PowerView's Get-NetDomainController]].

---

## get-netcomputer

Gathers information on the computers in the domain.

```bash
pywerview get-netcomputer -w $DOMAIN -u $USER [-p $PASSWORD|--hashes $LMHASH$:NTHASH] --dc-ip $DOMAIN_CONTROLLER_HOSTNAME_OR_IP [--computername $COMPUTER_NAME_OR_IP] --full-data
```

- Omitting `--computername` will retrieve all computers.

On Windows: [[powerview#Get-DomainComputer|PowerView's Get-DomainComputer]].

---

## get-netgroup

Gathers information on the groups in the domain.

```bash
pywerview get-netgroup -w $DOMAIN -u $USER [-p $PASSWORD|--hashes $LMHASH$:NTHASH] --dc-ip $DOMAIN_CONTROLLER_HOSTNAME_OR_IP [--groupname $COMPUTER_NAME_OR_IP] --full-data
```

- Omitting `--groupname` will retrieve all groups.

---

## get-netuser

```bash
pywerview get-netuser -w $DOMAIN -u $USER [-p $PASSWORD|--hashes $LMHASH$:NTHASH] --dc-ip $DOMAIN_CONTROLLER_HOSTNAME_OR_IP [--username $USERNAME]
```

- Omitting `--username` will retrieve all users.

---

## Gather Users that are [[ASREP-roasting|ASREP-Roastable]]

```bash
pywerview get-netuser -w $DOMAIN -u $USER [-p $PASSWORD|--hashes $LMHASH$:NTHASH] --dc-ip $DOMAIN_CONTROLLER_HOSTNAME_OR_IP [--username $USERNAME] --preauth-notreq
```

---

## Gather Users that are [[kerberoasting|Kerberoastable]]

```bash
pywerview get-netuser -w $DOMAIN -u $USER [-p $PASSWORD|--hashes $LMHASH$:NTHASH] --dc-ip $DOMAIN_CONTROLLER_HOSTNAME_OR_IP [--username $USERNAME] --spn
```

---

## Gather Users that have AdminCount = 1

```bash
pywerview get-netuser -w $DOMAIN -u $USER [-p $PASSWORD|--hashes $LMHASH$:NTHASH] --dc-ip $DOMAIN_CONTROLLER_HOSTNAME_OR_IP [--username $USERNAME] --admin-count
```

---

## Gather Computers Configured with [[unconstrained-delegation|Unconstrained Delegation]]

```bash
pywerview get-netcomputer -w $DOMAIN -u $USER [-p $PASSWORD|--hashes $LMHASH$:NTHASH] --dc-ip $DOMAIN_CONTROLLER_HOSTNAME_OR_IP --unconstrained [--full-data]
```

---

## Gather Computers & Users Configured with [[constrained-delegation|Constrained Delegation]]

```bash
pywerview get-netcomputer -w $DOMAIN -u $USER [-p $PASSWORD|--hashes $LMHASH$:NTHASH] --dc-ip $DOMAIN_CONTROLLER_HOSTNAME_OR_IP --full-data | grep -a TRUSTED_TO_AUTH_FOR_DELEGATION -B 50 -A 20
```

```bash
pywerview get-netuser -w $DOMAIN -u $USER [-p $PASSWORD|--hashes $LMHASH$:NTHASH] --dc-ip $DOMAIN_CONTROLLER_HOSTNAME_OR_IP --custom-filter "(userAccountControl:1.2.840.113556.1.4.803:=16777216)"
```

---

## Return Users who are not Marked as "Sensitive and Not Allowed for Delegation"

```bash
pywerview get-netcomputer -w $DOMAIN -u $USER [-p $PASSWORD|--hashes $LMHASH$:NTHASH] --dc-ip $DOMAIN_CONTROLLER_HOSTNAME_OR_IP --allow-delegation [--full-data]
```
