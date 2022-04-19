 	# `proc` Filesystem

> The `proc` filesystem is a pseudo-filesystem which provides an interface to kernel data structures. It is commonly mounted at `/proc`.

---

## `/proc/sched_debug`

Contains a list of the running processes on each of the system's CPUs.

---

## `/proc/$PID/`

Each one of these subdirectories contains files and subdirectories exposing information about the process identified by `$PID`.

### `/proc/$PID/cmdline`

The complete command line for the process.

### `/proc/$PID/maps`

The currently mapped memory regions and their address ranges and permissions.

### `/proc/$PID/cwd`

Symbolic link to the process's current working directory.

### `/proc/$PID/exe`

The process's executable.

### `/proc/$PID/environ`

The process's environment variables.

---

## `/proc/self/`

A symbolic link to the current process's [[proc-filesystem#proc PID|/proc subdirectory]].

---

## `/proc/net/`

Each of the files in this directory contain networking information about the system. In fact, many common network utilities (`netstat`, `arp`, `ifconfig`, etc.) pull information from these files.

### `/proc/net/arp`

ARP cache.

### `/proc/net/dev`

Network interfaces.

### `/proc/net/route`

Routing table.

### `/proc/net/tcp`

IPv4 TCP socket table. Can be used to enumerate network connections and listening ports. IP addresses are in hex. If the `rem_address` field is null, `local_address` represents a listening socket. Addresses are in little endian.

### `/proc/net/tcp6`

IPv6 TCP socket table. Same as `/proc/net/tcp`, but for IPv6.

### `/proc/net/udp`

IPv4 UDP socket table.

### `/proc/net/udp6`

IPv6 UDP socket table. Same as `/proc/net/udp`, but for iPv6.

### `/proc/net/wireless`

Contains wireless device information.

---

## `/proc/mount`

Mounted filesystems.

---

## `/proc/version`

Kernel version.

---

## References

[proc(5) Man Page](https://man7.org/linux/man-pages/man5/proc.5.html)

[Linux Enumeration with Read Access Only - Ring 0x00](https://idafchev.github.io/enumeration/2018/03/05/linux_proc_enum.html)
