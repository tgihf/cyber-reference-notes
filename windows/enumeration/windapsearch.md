# [windapsearch.py](https://github.com/ropnop/windapsearch)

Python script to enumerate an Active Directory domain from a **non-domain joined** machine (i.e., your attacker box) by automating the relevant LDAP queries to the domain controller. All you need is valid credentials and the IP address of the domain controller.

## Activate virtual environment

```bash
cd /usr/share/windapsearch
source windapsearch/bin/activate
```

## Enumerate domain users

```bash
python windapsearch.py -u $USERNAME@$DOMAIN -p $PASSWORD   --dc-ip $DOMAIN_CONTROLLER_IP -U
```

## Enumerate privileged domain users

```bash
python windapsearch.py -u $USERNAME@$DOMAIN -p $PASSWORD --dc-ip $DOMAIN_CONTROLLER_IP -PU
```

## Enumerate domain groups

```bash
python windapsearch.py -u $USERNAME@$DOMAIN -p $PASSWORD --dc-ip $DOMAIN_CONTROLLER_IP -G
```

## Enumerate domain computers

```bash
python windapsearch.py -u $USERNAME@$DOMAIN -p $PASSWORD --dc-ip $DOMAIN_CONTROLLER_IP -C
```

## Enumerate all members of a group

```bash
python windapsearch.py -u $USERNAME@$DOMAIN -p $PASSWORD --dc-ip $DOMAIN_CONTROLLER_IP -m $GROUP_NAME
```

## Enumerate all members of the Domain Admins group

```bash
python windapsearch.py -u $USERNAME@$DOMAIN -p $PASSWORD --dc-ip $DOMAIN_CONTROLLER_IP --da
```

## Enumerate all users with protected ACLs (i.e., admins)

```bash
python windapsearch.py -u $USERNAME@$DOMAIN -p $PASSWORD --dc-ip $DOMAIN_CONTROLLER_IP --admin-objects
```

## Enumerate all users with service principal names (for kerberoasting)

```bash
python windapsearch.py -u $USERNAME@$DOMAIN -p $PASSWORD --dc-ip $DOMAIN_CONTROLLER_IP --user-spns
```

## Enumerate all users with unconstrained delegation

```bash
python windapsearch.py -u $USERNAME@$DOMAIN -p $PASSWORD --dc-ip $DOMAIN_CONTROLLER_IP --unconstrained-users
```

## Enumerate all computers with unconstrained delegation

```bash
python windapsearch.py -u $USERNAME@$DOMAIN -p $PASSWORD --dc-ip $DOMAIN_CONTROLLER_IP --unconstrained-computers
```

## Enumerate group policy objects (GPOs)

```bash
python windapsearch.py -u $USERNAME@$DOMAIN -p $PASSWORD --dc-ip $DOMAIN_CONTROLLER_IP --gpos
```
