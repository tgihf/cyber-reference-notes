# Linux Situational Awareness

---

## System Enumeration

### Kernel Version

```bash
uname -a
```

```bash
cat /proc/version
```

### Distribution Version

```bash
cat /etc/issue
```

### CPU Architecture, Thread, and Core Count

```bash
uname -a
```

```bash
lscpu
```

### Current Running Processes

```bash
ps auxef
```

---

## User Enumeration

### Current User

```bash
id
```

```bash
whoami
```

### Current User's Allowed and Disallowed `sudo` Commands

Commands marked `(root) NOPASSWD` can be executed as `root` without providing the current user's password.

Commands marked `(root)` can be executed as `root` but require providing the current user's password.

```bash
sudo -l
```

### Current User's Execution History

```bash
history
```

```bash
cat /home/$USERNAME/.bash_history
```

### Users

```bash
cat /etc/passwd
```

### Groups

```bash
cat /etc/groups
```

---

## Network Enumeration

### Network Interfaces

```bash
ifconfig
```

```bash
ip a
```

### Routing table

```bash
route
```

```bash
ip route
```

### ARP Cache

```bash
arp -a
```

```bash
ip neigh
```

### Current Network Listeners & Connections

```bash
netstat -ano
```
