# Tunneling with Windows' `netsh`

> `netsh` (Network Shell) is a Windows command-line utility for configuring the machine's network components, including its firewall. It can be leveraged to configure port forwarding via the firewall.

---

## Configure Port Forward

- Requires local administrator privielges

```batch
netsh interface portproxy add v4tov4 listenaddress=$LOCAL_LISTEN_ADDRESS listenport=$LOCAL_LISTEN_PORT connectaddress=$REMOTE_CONNECT_ADDRESS connectport=$REMOTE_CONNECT_PORT protocol=$PROTOCOL
```

To create a tunnel from the executing machine's `0.0.0.0`'s TCP port `8000` to `1.2.3.4`'s TCP port `8001`, you'd use the following options:

- `$LOCAL_LISTEN_ADDRESS`: `0.0.0.0`
- `$LOCAL_LISTEN_PORT`: `8000`
- `$REMOTE_CONNECT_ADDRESS`: `1.2.3.4`
- `$REMOTE_CONNECT_PORT`: `8001`
- `PROTOCOL`: `tcp`

From the perspective of the executing machine, this is a [[local-port-forwarding|local port forward]], except the traffic isn't really tunneled through the "server," but forwarded directly to `$REMOTE_CONNECT_ADDRESS`:`$REMOTE_CONNECT_PORT`.

From the perspective of an attacker executing the command on the executing machine, it could be considered a [[remote-port-forwarding|remote port forward]], except the traffic isn't tunneled through the "client" (attacker), but is forwarded directly.

You won't see any output from the above command, but you can check if it worked with:

```batch
netsh interface portproxy show v4tov4 
```
