# Secure Shell (SSH)

> A cryptographic network protocol for operating network services securely over an unsecured network.

## Check if `root` can login to the machine with just a password

```bash
cat /etc/ssh/sshd_config | grep PermitRootLogin
```