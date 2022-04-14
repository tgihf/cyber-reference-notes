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

## References

[proc(5) Man Page](https://man7.org/linux/man-pages/man5/proc.5.html)

[Linux Enumeration with Read Access Only - Ring 0x00](https://idafchev.github.io/enumeration/2018/03/05/linux_proc_enum.html)
