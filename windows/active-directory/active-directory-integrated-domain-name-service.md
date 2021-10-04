# [Active Directory Integrated Domain Name Service (ADIDNS)](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/plan/active-directory-integrated-dns-zones)

> Domain name service integrated into Active Directory.

---

## Add Record to ADIDNS Server

By default, any domain user can add a record to an ADIDNS server. To do so from a Linux machine:

```bash
python3 /usr/share/responder/toolsDNSUpdate.py -DNS $ADIDNS_SERVER -u '$DOMAIN\$USERNAME' -p '$PASSWORD' -a ad -r $HOSTNAME -d $IP_ADDRESS
```

This will add the A record `$HOSTNAME.$DOMAIN` -> `$IP_ADDRESS`.

For example, tthe following command will add the A record `webtgihf.intelligence.htb` -> `10.10.10.10`.

```bash
python3 /usr/share/responder/toolsDNSUpdate.py -DNS dc.intelligence.htb -u 'intelligence.htb\Ted.Graves' -p 'Mr.Teddy' -a ad -r webtgihf -d 10.10.10.10
```
