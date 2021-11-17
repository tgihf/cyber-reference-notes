# Remote Port Forwarding

> The server forwards one of its ports through the client to a port that is accessible by the client.

---

## Forward an Attacker-Accessible Port to a Port that is Accessible by a Remote Target (**without** SSH Access to the Remote Target)

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

## Theory

![[remote-port-forwarding-1.png]]

![[remote-port-forwarding-2.png]]
