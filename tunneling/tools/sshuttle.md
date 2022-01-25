# [shuttle](https://sshuttle.readthedocs.io/en/stable/usage.html)

---

## Dynamic Local Port Forwarding without `socks` Proxy

For a client to establish a dynamic local port forwading connection through an SSH server to an arbitrary IP address or CIDR:

```bash
sshuttle -r $USERNAME@$SSH_SERVER_FQDN_OR_IP $IP_OR_CIDR_TO_FORWARD_TO
```

- `$USERNAME`: user to log in to the SSH server as
- `$SSH_SERVER_FQDN_OR_IP`: self-explanatory
- `$IP_OR_CIDR_TO_FORWARD_TO`: the IP address or CIDR you want to forward traffic from the client through the SSH server to

`sshuttle` doesn't require a [[socks]] proxy to achieve dynamic port forwarding. Instead, it automatically routes traffic bound for `$IP_OR_CIDR_TO_FORWARD_TO` through the SSH server.

This does require [[sudo]] access to the client machine and the credential for `$USERNAME` on the SSH server.

---

## References

[Conda - Using SSHuttle to Pivot Across Networks](https://www.youtube.com/watch?v=lGr7VUCBvOQ)