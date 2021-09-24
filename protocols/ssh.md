# Secure Shell (SSH)

> A cryptographic network protocol for operating network services securely over an unsecured network.

---

## Check if `root` can login to the machine with just a password

```bash
cat /etc/ssh/sshd_config | grep PermitRootLogin
```

---

## `~/.ssh/authorized_keys` `from` Prefix

A user's `~/.ssh/authorized_keys` file specifies all of the public keys whose corresponding private keys can be used to login via SSH as that user. A typical example entry:

```txt
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDF4pkc7L5EaGz6CcwSCx1BqzuSUBvfseFUA0mBjsSh7BPCZIJyyXXjaS69SHEu6W2UxEKPWmdlj/WwmpPLA8ZqVHtVej7aXQPDHfPHuRAWI95AnCI4zy7+DyVXceMacK/MjhSiMAuMIfdg9W6+6EXTIg+8kN6yx2i38PZU8mpL5MP/g2iDKcV5SukhbkNI/4UvqheKX6w4znOJElCX+AoJZYO1QcdjBywmlei0fGvk+JtTwSBooPr+F5lewPcafVXKw1l2dQ4vONqlsN1EcpEkN+28ndlclgvm+26mhm7NNMPVWs4yeDXdDlP3SSd1ynKEJDnQhbhc1tcJSPEn7WOD bindmgr@nomen
```

These entries can also be prepended with a `from="$PATTERN_LIST"` clause, like so:

```txt
from="*.infra.dyna.htb" ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDF4pkc7L5EaGz6CcwSCx1BqzuSUBvfseFUA0mBjsSh7BPCZIJyyXXjaS69SHEu6W2UxEKPWmdlj/WwmpPLA8ZqVHtVej7aXQPDHfPHuRAWI95AnCI4zy7+DyVXceMacK/MjhSiMAuMIfdg9W6+6EXTIg+8kN6yx2i38PZU8mpL5MP/g2iDKcV5SukhbkNI/4UvqheKX6w4znOJElCX+AoJZYO1QcdjBywmlei0fGvk+JtTwSBooPr+F5lewPcafVXKw1l2dQ4vONqlsN1EcpEkN+28ndlclgvm+26mhm7NNMPVWs4yeDXdDlP3SSd1ynKEJDnQhbhc1tcJSPEn7WOD bindmgr@nomen
```

This clause indicates that only machines whose IP addresses map to a hostname in the `infra.dyna.htb` domain will be allowed to login via SSH with the corresponding private key.

How does the server determine the SSH client's hostname? By querying its DNS server for (1) a [[dns#PTR Record https simpledns plus help ptr-records|PTR]] record that maps the client's IP address to a domain name and (2) an [[dns#A Record https simpledns plus help a-records|A record]] that maps the domain name from the PTR record to the client's IP address. It will then compare the domain name from the PTR record to determine if the client is allowed to login using the private key.

It is also possible to pass IP address patterns and CIDR ranges into the `from` clause. See `ssh_config`'s man page's `PATTERNS` section and [this Unix Stack Exchange post](https://unix.stackexchange.com/questions/353044/how-to-restrict-an-ssh-key-to-certain-ip-addresses) for more details.
