# Environment Variables

> Configuration variables for each login session.

---

## Inheritance

`sudo` child processes **do not** inherit the login session's environment variables unless they are specified in the `env_keep` directive (viewable via [[situational-awareness#Current User's Allowed and Disallowed sudo Commands|sudo -l]]).
- When the [[LD_PRELOAD]] environment variable is inherited, there is a direct [[sudo-for-privesc#LD_PRELOAD Exploitation|privilege escalation path]].

SUID child processes **do** inherit the login session's environment variables.
- When a SUID executable runs a command without an absoluate path, there is a direct [[suid-for-privesc#SUID Exploitation via PATH|privilege escalation path]].

Regular child processes **do** inherit the login session's environment variables.

---

## View Environment Variables

```bash
env
```
