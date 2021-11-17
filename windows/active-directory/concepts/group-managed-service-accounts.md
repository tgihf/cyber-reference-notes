# [Group Managed Service Accounts (GMSA)](https://docs.microsoft.com/en-us/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview)

> A special type of Active Directory account whose password is managed by and automatically changed by Domain Controllers at a set interval. The intended use of a GMSA is to allow certain computer accounts to retrieve the password for the GMSA and then run local services as the GMSA. An attacker with access to an account who can retrieve a GMSA's password can impersonate the GMSA.

---

## Determine a GMSA's Password Change Interval

Use [[powerview|PowerView]] or [[pywerview|pywerview's]] `Get-ADObject` command to read the GMSA object's `MSDS-ManagedPasswordInterval` attribute.

---

## Determine What Principals can Retrieve a GMSA's Password Hash

Obtain a domain user's credentials and run [[bloodhound|BloodHound]]. Run the following Cypher query to retrieve all of the nodes who have the `ReadGMSAPassword` privilege on the GMSA.

```cypher
MATCH p=(m)-[r:ReadGMSAPassword]->(n {name: "$NAME"}) RETURN *
```

`$NAME` might take the format `$USERNAME@$DOMAIN`. For example: `SVC_INT@INTELLIGENCE.HTB`.

![[Pasted image 20211001212512.png]]

---

## Retrieve a GMSA's Password Hash

With the credentials of an account who has `ReadGMSAPassword` permission to the GMSA (see above), use [gMSADumper.py](https://github.com/micahvandeusen/gMSADumper).

```bash
python3 /opt/gMSADumper/gMSADumper.py -d $DOMAIN -u $USERNAME -p $PASSWORD
```

This will dump the password hashes of all the GMSA accounts `$USERNAME` has `ReadGMSAPassword` permission for.

---

## More Resources

[Reading GSMA password](https://gitlab.com/pentest-tools/PayloadsAllTheThings/-/blob/master/Methodology%20and%20Resources/Active%20Directory%20Attack.md#reading-gmsa-password)
