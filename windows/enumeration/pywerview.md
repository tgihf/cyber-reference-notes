# [pywerview](https://github.com/the-useless-one/pywerview)

> A partial rewrite of PowerSploit's [[powerview|PowerView]] in Python for Linux users.

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

- No `computername` will retrieve all computers.

On Windows: [[powerview#Get-DomainComputer|PowerView's Get-DomainComputer]].

---

## get-netgroup

Gathers information on the groups in the domain.

```bash
pywerview get-netgroup -w $DOMAIN -u $USER [-p $PASSWORD|--hashes $LMHASH$:NTHASH] --dc-ip $DOMAIN_CONTROLLER_HOSTNAME_OR_IP [--groupname $COMPUTER_NAME_OR_IP] --full-data
```

- No `groupname` will retrieve all groups.

---

## get-netuser

```bash
pywerview get-netuser -w $DOMAIN -u $USER [-p $PASSWORD|--hashes $LMHASH$:NTHASH] --dc-ip $DOMAIN_CONTROLLER_HOSTNAME_OR_IP [--username $USERNAME]
```

- No `username` will retrieve all users.
