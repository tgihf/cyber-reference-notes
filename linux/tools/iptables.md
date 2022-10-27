# iptables

> De facto tool for setting up, maintaining, and inspecting the tables of IP packet filter rules in the Linux kernel.

---

## TCP Redirection

Redirect all traffic on `localhost`:`$LOCAL_TCP_PORT` to `$REMOTE_HOST_IP`:`$REMOTE_TCP_PORT`.

```bash
$ iptables -I INPUT -p tcp -m tcp --dport $LOCAL_TCP_PORT -j ACCEPT
$ iptables -t nat -A PREROUTING -p tcp --dport $LOCAL_TCP_PORT -j DNAT --to-destination $REMOTE_HOST:$REMOTE_TCP_PORT
$ iptables -t nat -A POSTROUTING -j MASQUERADE
$ iptables -I FORWARD -j ACCEPT
$ iptables -P FORWARD ACCEPT
$ sysctl net.ipv4.ip_forward=1
```

- `PREROUTING`: alter packet on the way in
- `POSTROUTING`: alter packet on the way out
	- `MASQUERADE`: only valid in `nat` table and `POSTROUTING` chain, allowing network traffic to traverse to another network

See [bluescreenofjeff's Red Team Infrastructure Wiki](https://github.com/bluscreenofjeff/Red-Team-Infrastructure-Wiki#iptables-for-http).

---

## UDP Redirection

Redirect all traffic on `localhost`:`$LOCAL_UDP_PORT` to `$REMOTE_HOST_IP`:`$REMOTE_UDP_PORT`.

```bash
iptables -I INPUT -p udp -m udp --dport $LOCAL_UDP_PORT -j ACCEPT
iptables -t nat -A PREROUTING -p udp --dport $LOCAL_UDP_PORT -j DNAT --to-destination $REMOTE_HOST_IP:$REMOTE_UDP_PORT
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -I FORWARD -j ACCEPT
iptables -P FORWARD ACCEPT
sysctl net.ipv4.ip_forward=1
```

- `PREROUTING`: alter packet on the way in
- `POSTROUTING`: alter packet on the way out
	- `MASQUERADE`: only valid in `nat` table and `POSTROUTING` chain, allowing network traffic to traverse to another network

See [bluescreenofjeff's Red Team Infrastructure Wiki](https://github.com/bluscreenofjeff/Red-Team-Infrastructure-Wiki#iptables-for-dns).

---

## Redirector Hardening

Only allow your C2 server and systems from the target network to connect to the redirector's redirected ports.

1. (Optional) Flush existing rules

```bash
iptables -F
```

2. Accept connections from C2 server

```bash
iptables -A INPUT -I $INTERFACE -s $C2_SERVER_IP/32 -j ACCEPT
```

3. Accept connections from target network to local TCP port 80

```bash
iptables -A INPUT -I $INTERFACE -s $TARGET_NETWORK_CIDR -p tcp -dport 80 -m state --state RELATED,ESTABLISHED -m comment --comment "Allow target traffic inbound to port 80 for redirection" -j ACCEPT
```

Note that you'll want to repeat #3 for each port the redirector is forwarding to the C2 server.

4. Allow existing connections to continue

```bash
iptables -A INPUT -I $INTERFACE -m state --state ESTABLISHED,RELATED -j ACCEPT
```

5. Drop everything else by default

```bash
iptables -P INPUT DROP
```

---

## C2 Server Hardening

Only allow your redirectors and C2 clients to connect to your C2 server.

1. (Optional) Flush existing rules

```bash
iptables -F
```

2. Accept connections from redirectors

```bash
iptables -A INPUT -I $INTERFACE -s $REDIRECTOR_IP/32 -j ACCEPT
```

Note that you'll want to repeat #2 for each redirector.

2. Accept connections from C2 clients

```bash
iptables -A INPUT -I $INTERFACE -s $C2_CLIENT_IP/32 -j ACCEPT
```

Note that you'll want to repeat #3 for each C2 client.

3. Allow existing connections to continue

```bash
iptables -A INPUT -I $INTERFACE -m state --state ESTABLISHED,RELATED -j ACCEPT
```

4. Drop everything else by default

```bash
iptables -P INPUT DROP
```

---

## References

[iptables Man Page -die.net](https://linux.die.net/man/8/iptables)
