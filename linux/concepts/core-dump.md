#  Core Dump

> When a process crashes, depending on the system's configuration, a core dump may be produced. A core dump is a snapshot of the process's memory as it crashed.

---

## Disabling, Enabling, & Configuring Core Dumps in Linux

[linux-audit.com - Understand & Configure Core Dumps on Linux](https://linux-audit.com/understand-and-configure-core-dumps-work-on-linux/)

---

## Core Dump & Privileged File Reads

If you're able to execute a privileged program (via `sudo`, SUID/SGID, etc.) that reads an arbitrary file, you may be able to crash the program and produce a core dump that will contain the contents of the arbitrary file.

### Process

1. Run the privilege program and have it read the target file
2. While the program has the file's contents loaded in memory and hasn't exited, cause it to crash
	- Example: you could background it (`Ctrl-Z`), gets the process's PID, and [[kill#Cause a process to segfault resulting in a memory dump|kill it with a SIGSEGV signal]]
3. Read the target file from the core dump
	- Ubuntu system: see [[apport|Apport]]
	- See [here](https://linux-audit.com/understand-and-configure-core-dumps-work-on-linux/) for more details on reading core dumps on other types of systems

