# Linux Privilege Escalation

The process of escalating privileges on a Linux machine involves careful enumeration. Work through the following steps for consistency and thoroughness.

---

## 1. Situational Awareness

See [[situational-awareness|here]].

---

## `sudo` Exploitation

See [[sudo-for-privesc|here]].

---

## SUID Exploitation

See [[suid-for-privesc|here]].

---

## Capabilities Exploitation

See [[capabilities-for-privesc|here]].

---

## `cron` Exploitation

See [[cron-for-privesc|here]].

---

## `systemd` Timer Exploitation

See [[systemd-timers-for-privesc|here]].

---

## Exploitable Permissions on Sensitive Files

Iterate through each of the machine's [[sensitive-files|sensitive files]], seeing if your current security context has the desired permissions.

---

## Credential Hunting

See [[credential-hunting|here]].

---

## Kernel Exploits

See [[kernel-exploits|here]].

---

## With Administrative Access, Capture and Analyze Network Traffic

```bash
tcpdump -i $INTERFACE -nt '$FILTER' -vX [-w $OUTPUT_FILE]
```

---

## Credential Hunting

Recursively search `$DIRECTORY` for SSH keys.

```bash
find $DIRECTORY -name id_rsa 2> /dev/null
```

```bash
grep --color=auto -rnw $DIRECTORY -ie "PRIVATE KEY" --color=always 2> /dev/null
```

Recursively search `$DIRECTORY` for the word "PASSWORD." Feel free to try other variations, like "passwd," "pass", or "pwd."

```bash
grep --color=auto -rnw $DIRECTORY -ie "PASSWORD" --color=always 2> /dev/null
```

Do the same as the above, but also search for hidden directories.

```bash
find $DIRECTORY -type f -exec grep -i -I "PASSWORD" {} /dev/null \;
```

Find all files whose names' **contain** the word "password."

```bash
locate password
```

```bash
find $DIRECTORY -name password 2> /dev/null
```

---

## Automated Privilege Escalation Enumeration

**Enumeration**

- [[linpeas|linpeas.sh (bash)]]
- [[linenum|linenum.sh (bash)]]
- [[linuxprivchecker|linuxprivchecker.py (Python 2 default, 3 available)]]

**Exploit Suggestion**
- [[linux-exploit-suggester|Linux Exploit Suggester]]

---

## References

[Conda's Privilege Escalation Maps](https://github.com/C0nd4/OSCP-Priv-Esc)

[sushant747's Linux Privilege Escalation](https://sushant747.gitbooks.io/total-oscp-guide/content/privilege_escalation_-_linux.html)

[PayloadsAllTheThings Linux Privilege Escalation](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Linux%20-%20Privilege%20Escalation.md)

[HackTricks Linux Privilege Escalation](https://book.hacktricks.xyz/linux-unix/privilege-escalation)

[g0tmi1k's Basic Linux Privilege Escalation Blog](https://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/)
