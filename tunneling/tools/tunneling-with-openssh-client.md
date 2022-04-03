# Tunneling with the OpenSSH Client (`ssh`)

---

## Local Port Forwarding

See [[local-port-forwarding]] for a definition and helpful diagrams.

From the SSH client:

```bash
ssh $USERNAME@$SSH_SERVER_FQDN_OR_IP -L $SSH_CLIENT_LISTEN_PORT:$SSH_SERVER_ACCESSIBLE_DESTINATION_FQDN_OR_IP:$SSH_SERVER_ACCESSIBLE_DESTINATION_PORT
```

This creates an SSH tunnel from the client's `$SSH_CLIENT_LISTEN_PORT` **through the SSH server** to `$SSH_SERVER_ACCESSIBLE_DESTINATION_FQDN_OR_IP`:`$SSH_SERVER_ACCESSIBLE_DESTINATION_PORT`.

Since `$SSH_SERVER_ACCESSIBLE_DESTINATION_FQDN_OR_IP`:`$SSH_SERVER_ACCESSIBLE_DESTINATION_PORT` is accessible from the SSH server, it can be `localhost` and some port to forward **to** the SSH server.

Example:

```bash
ssh tgihf@vm.tgihf.click -L 1234:blah.tgihf.click:5678
```

This creates an SSH tunnel from the client's TCP port `1234` through the SSH server, `vm.tgihf.click`, to `blah.tgihf.click`:`5678`.

---

## Remote Port Forwarding

See [[remote-port-forwarding]] for a definition and helpful diagrams.

From the SSH client:

```bash
ssh $USERNAME@$SSH_SERVER_FQDN_OR_IP -R $SSH_SERVER_LISTEN_PORT:$SSH_CLIENT_ACCESSIBLE_DESTINATION_FQDN_OR_IP:$SSH_CLIENT_ACCESSIBLE_DESTINATION_PORT
```

This creates an SSH tunnel from the server's `$SSH_SERVER_LISTEN_PORT` **through the SSH client** to `$SSH_CLIENT_ACCESSIBLE_DESTINATION_FQDN_OR_IP`:`SSH_CLIENT_ACCESSIBLE_DESTINATION_PORT`.

Since `SSH_CLIENT_ACCESSIBLE_DESTINATION_FQDN_OR_IP`:`SSH_CLIENT_ACCESSIBLE_DESTINATION_PORT` is accessible from the SSH client, it can be `localhost` and some port to forward **to** the SSH client.

Example:

```bash
ssh tgihf@vm.tgihf.click -R 1234:blah.tgihf.click:5678
```

This creates an SSH tunnel from the SSH server's TCP port `1234` (`vm.tgihf.click`:`1234`) through the SSH client to `blah.tgihf.click`:`5678`.

---

## Dynamic Local Port Forwarding

See [[dynamic-port-forwarding#Dynamic Local Port Forwarding|dynamic local port forwarding]] for a definition and example.

```bash
ssh $USERNAME@$SSH_SERVER_FQDN_OR_IP -D $SSH_CLIENT_SOCKS_PROXY_PORT
```

This creates an SSH tunnel from the client's `$SSH_CLIENT_SOCKS_PROXY_PORT` **through the SSH server** and to any endpoint accessible by the SSH server via the [[socks]] protocol.

Example:

```bash
$ ssh tgihf@vm.tgihf.click -D 1080
```

This creates an SSH tunnel from the client's port 1080 through the SSH server (`vm.tgihf.click`) and to any endpoint accessible by the SSH server via the [[socks]] protocol. Use [[proxychains]] to pass traffic through this tunnel.

---

## Dynamic Remote Port Forwarding

See [[dynamic-port-forwarding#Dynamic Remote Port Forwarding|dynamic remote port forwarding]] for a definition and example.

```bash
ssh $USERNAME@$SSH_SERVER_FQDN_OR_IP -R $SSH_SERVER_SOCKS_PROXY_PORT
```

This creates an SSH tunnel from the SSH server's `$SSH_SERVER_SOCKS_PROXY_PORT` **through the SSH client** and to any endpoint accessible by the SSH client via the [[socks]] protocol.

Example:

```bash
$ ssh tgihf@vm.tgihf.click -R 1080
```

This creates an SSH tunnel from the SSH server's port 1080 (`vm.tgihf.click`:`1080`) through the SSH client and to any endpoint accessible by the SSH client via the [[socks]] protocol. Use [[proxychains]] to pass traffic through this tunnel.
