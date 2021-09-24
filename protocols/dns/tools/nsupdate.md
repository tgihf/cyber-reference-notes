# [nsupdate](https://linux.die.net/man/8/nsupdate)

> A command-line tool for submiting [[dynamic-dns|Dynamic DNS]] Update requests as defined in [RFC2136](https://datatracker.ietf.org/doc/html/rfc2136) to a name server. This allows resource records to be added or removed from a zone without manually editing the zone file. A single update request can contain requests to add or remove more than one resource record.

---

## Add an [[dns#A Record https simpledns plus help a-records|A Record]] to a DNS Server **Interactively**

```bash
$ nsupdate [-k $KEY_FILE]
> server $DNS_SERVER_HOSTNAME_OR_IP
> update delete $HOSTNAME A
> update add $HOSTNAME $TTL_IN_SECONDS A $IP_ADDRESS
> send
```

- Only include `update delete $HOSTNAME A` line if updating an existing record

---

## Add an [[dns#A Record https simpledns plus help a-records|A Record]] to a DNS Server **Non-Interactively**

```bash
$ echo "server $DNS_SERVER_HOSTNAME_OR_IP
update delete $HOSTNAME A
update add $HOSTNAME $TTL_IN_SECONDS A $IP_ADDRESS
send" | nsupdate [-k $KEY_FILE]
```

- Only include `update delete $HOSTNAME A` line if updating an existing record

---

## Add a [[dns#PTR Record https simpledns plus help ptr-records|PTR Record]] to a DNS Server **Interactively**

```bash
$ nsupdate [-k $KEY_FILE]
> server $DNS_SERVER_HOSTNAME_OR_IP
> update delete $IP_REVERSE_IN-ADDR_ARPA PTR
> update add $IP_REVERSE_IN-ADDR_ARPA 3600 PTR $HOSTNAME
> send
```

- If trying to add a record for the IPv4 address `1.2.3.4`, then `$IP_REVERSE_IN-ADDR_ARPA` would be `4.3.2.1.in-addr-arpa`
- Only include `update delete $IP_REVERSE_IN-ADDR_ARPA PTR` line if updating an existing record

---

## Add a [[dns#PTR Record https simpledns plus help ptr-records|PTR Record]] to a DNS Server **Non-Interactively**

```bash
$ echo "server $DNS_SERVER_HOSTNAME_OR_IP
update delete $IP_REVERSE_IN-ADDR_ARPA PTR
update add $IP_REVERSE_IN-ADDR_ARPA 3600 PTR $HOSTNAME
send" | nsupdate [-k $KEY_FILE]
```

- If trying to add a record for the IPv4 address `1.2.3.4`, then `$IP_REVERSE_IN-ADDR_ARPA` would be `4.3.2.1.in-addr-arpa`
- Only include `update delete $IP_REVERSE_IN-ADDR_ARPA PTR` line if updating an existing record

---

## Add/Update Multiple Types of Records to a DNS Server **Interactively**

This example adds one [[dns#A Record https simpledns plus help a-records|A record]] and one [[dns#PTR Record https simpledns plus help ptr-records|PTR record]].

```bash
$ nsupdate [-k $KEY_FILE]
> server $DNS_SERVER_HOSTNAME_OR_IP
> update delete $HOSTNAME A
> update add $HOSTNAME $TTL_IN_SECONDS A $IP_ADDRESS
>
> update delete $IP_REVERSE_IN-ADDR_ARPA PTR
> update add $IP_REVERSE_IN-ADDR_ARPA 3600 PTR $HOSTNAME
> send
```

- If trying to add a [[dns#PTR Record https simpledns plus help ptr-records|PTR record]] for the IPv4 address `1.2.3.4`, then `$IP_REVERSE_IN-ADDR_ARPA` would be `4.3.2.1.in-addr-arpa`
- Only include the `update delete` lines if updating an existing record
- **Note** the required blank line between the two additions/updates

---

## Add/Update Multiple Types of Records to a DNS Server **Non-Interactively**

This example adds one [[dns#A Record https simpledns plus help a-records|A record]] and one [[dns#PTR Record https simpledns plus help ptr-records|PTR record]].

```bash
echo "server $DNS_SERVER_HOSTNAME_OR_IP
update delete $HOSTNAME A
update add $HOSTNAME $TTL_IN_SECONDS A $IP_ADDRESS

update delete $IP_REVERSE_IN-ADDR_ARPA PTR
update add $IP_REVERSE_IN-ADDR_ARPA 3600 PTR $HOSTNAME
send" | nsupdate [-k $KEY_FILE]
```

- If trying to add a [[dns#PTR Record https simpledns plus help ptr-records|PTR record]] for the IPv4 address `1.2.3.4`, then `$IP_REVERSE_IN-ADDR_ARPA` would be `4.3.2.1.in-addr-arpa`
- Only include the `update delete` lines if updating an existing record
- **Note** the required blank line between the two additions/updates