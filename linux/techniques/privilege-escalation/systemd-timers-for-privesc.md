# Privilege Escalation via `systemd` Timers

---

## What is a `systemd` Timer?

A [[systemd]] timer is a command executed by `systemd` (generally with elevated privileges) at a particular interval, date, or time. Very similar to a [[cron|cron job]].

---

## `systemd` Timer Privilege Escalation Process

1. [[systemd-timers-for-privesc#View all systemd Timers|Determine all systemd timers]]
2. For each `systemd` timer:
	- Evaluate the frequency, and command being executed and determine if it can be exploited
		- Is the frequency short enough to be exploited in the given time frame?
		- **Is the command configured without an absolute path?**
			- Can you get your own executable ahead of it in the `$PATH` search order?
				- What exactly is the `$PATH` for a `systemd` timer?
		- **Is the command configured with an absolute path?**
			- Do you have write access to the absolute path? Can you just replace it?
		- **Does the command contain a wildcard (`*`)?**
			- Attempt to abuse [[bash#Wildcard Behavior|bash's wildcard behavior]] to perform an elevated action
		- **Does a command the command fail to import a writable shared object file**?
			- Apply the [[shared-object-file-injection#Process|shared object file injection process]]

---

## View all `systemd` Timers

```bash
systemctl list-timers --all
```
