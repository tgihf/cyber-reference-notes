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

### Installed Applications

Refer to [here](https://unix.stackexchange.com/questions/20979/how-do-i-list-all-installed-programs) for more package systems.

On Aptitude-based systems:

```bash
dpkg -l
```

On RPM-based systems:

```bash
rpm -qa
```

---

## User Enumeration

### Current User

With `id`, note the current user's groups and look through [HackTricks' Linux privilege escalation via interesting groups page](https://book.hacktricks.xyz/linux-unix/privilege-escalation/interesting-groups-linux-pe) to see if any of the groups are exploitable.

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
cat /etc/group
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

```bash
ss -l
```
