# Linux Privilege Escalation

The process of escalating privileges on a Linux machine involves careful enumeration. Work through the following steps for consistency and thoroughness.

---

## 1. Situational Awareness

See [[situational-awareness|here]].

---

## Credential Hunting

Recursively search `$DIRECTORY` for SSH keys.

```bash
find $DIRECTORY -name id_rsa 2> /dev/null
```

```bash
grep --color=auto -rnw $DIRECTORY -ie "PRIVATE KEY" --color=always 2> /dev/null
```

Recursively search `$DIRECTORY` for the word "PASSWORD."

```bash
grep --color=auto -rnw $DIRECTORY -ie "PASSWORD" --color=always 2> /dev/null
```

Find all files that **contain** the word "password."

```bash
locate password
```

```bash
find $DIRECTORY -name password 2> /dev/null
```

---

## 3. [[capabilities#List All Binaries with Capabilities|Check Binaries with Capabilities]]

---

## 4. Run a Privilege Escalation Enumeration Script

- [linpeas.sh](https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/linPEAS)
	- **TODO**: figure out how to cleanly transfer the `linpeas.sh` output remotely

---

## 5. With Administrative Access, Capture and Analyze Network Traffic

```bash
tcpdump -i $INTERFACE -nt '$FILTER' -vX [-w $OUTPUT_FILE]
```

## Automated Privilege Escalation Enumeration

**Enumeration**

- [[linpeas|linpeas.sh (bash)]]
- [[linenum|linenum.sh (bash)]]
- 

**Exploit Suggestion**
- [[linux-exploit-suggester|Linux Exploit Suggester]]

---

## References

[Conda's Privilege Escalation Maps](https://github.com/C0nd4/OSCP-Priv-Esc)

[sushant747's Linux Privilege Escalation](https://sushant747.gitbooks.io/total-oscp-guide/content/privilege_escalation_-_linux.html)

[PayloadsAllTheThings Linux Privilege Escalation](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Linux%20-%20Privilege%20Escalation.md)

[HackTricks Linux Privilege Escalation](https://book.hacktricks.xyz/linux-unix/privilege-escalation)

[g0tmi1k's Basic Linux Privilege Escalation Blog](https://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/)
