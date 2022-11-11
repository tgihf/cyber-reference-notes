# Turning a Linux Machine into a Router with NAT

Assume we want to route traffic from `Network A` to `Network B`.

- `Nertwork A`: `192.168.1.0/24` attached to the Linux machine's interface `eth0`
	- The Linux machine's IP address on this network is `192.168.1.25`
- `Network B`: `10.10.10.0/24` attached to the Linux machine's interface `eth1`
	- The Linux machine's IP address on this network is `10.10.10.25`

## 1. Enable IPv4 Forwarding

```bash
sudo echo 1 > /proc/sys/net/ipv4/ip_forward
```

## 2. Create `iptables` Rules

```bash
$ sudo iptables -A FORWARD -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
$ sudo iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
$ sudo iptables -t nat -A POSTROUTING -s 192.168.1.25/24 -o eth1 -j MASQUERADE
```

## 3. Configure Clients to Use the Router

### Windows

```batch
route add 10.10.10.0 mask 255.255.255.0 192.168.1.25
```

### Linux

```bash
ip route add 10.10.10.0/24 via 192.168.1.25
```
