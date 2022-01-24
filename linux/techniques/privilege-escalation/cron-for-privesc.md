# Privilege Escalation via `cron`

---

## What is `cron`?

See [[cron|here]].

---

## `cron` Privilege Escalation Process

1. [[cron#View Configured Cron Jobs|Determine all of the configured cron jobs]]
2. For each configured `cron` job:
	- Evaluate the frequency, user, and command being executed and determine if it can be exploited
		- Is the frequency short enough to be exploited in the given time frame?
		- Is the user valuable?
		- **Is the command configured without an absolute path?**
			- Can you get your own executable ahead of it in the `$PATH` search order?
				- Remember that the `$PATH` may be specified in the `cron` file
		- **Is the command configured with an absolute path?**
			- Do you have write access to the absolute path? Can you just replace it?
		- **Does the command contain a wildcard (`*`)?**
			- Attempt to abuse [[bash#Wildcard Behavior|bash's wildcard behavior]] to perform an elevated action
		- **Does a command the command fail to import a writable shared object file**?
			- Apply the [[shared-object-file-injection#Process|shared object file injection process]]
