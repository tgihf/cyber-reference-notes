# Linux Privilege Escalation

The process of escalating privileges on a Linux machine involves careful enumeration. Work through the following steps for consistency and thoroughness.

---

## Linux Privilege Escalation Process

### 1. Situational Awareness

See [[linux-situational-awareness|here]].

### 2. Exploitable Permissions on Sensitive Files

Iterate through each of the machine's [[sensitive-files|sensitive files]], seeing if your current security context has the desired permissions.

### 3. `sudo` Exploitation

See [[sudo-for-privesc|here]].

### 4. SUID Exploitation

See [[suid-for-privesc|here]].

### 5. Capabilities Exploitation

See [[capabilities-for-privesc|here]].

### 6. `cron` Exploitation

See [[cron-for-privesc|here]].

### 7. `systemd` Timer Exploitation

See [[systemd-timers-for-privesc|here]].

### 8. NFS No `root` Squashing Exploitation

See [[nfs-no-root-squashing|here]].

### 9. Docker Privilege Escalation

Is [Docker](https://www.docker.com/) installed and is the current user a member of the `docker` group?

If so, you can create a container that mounts the system's root directory within the container and then changes its root directory to the system's root directory, effectively granting `root` access to the system.

Refer to the [docker shell entry on GTFOBins](https://gtfobins.github.io/gtfobins/docker/#shell) for an easy escalation.

### 10. `lxd` Privilege Escalation

Is [lxd](https://linuxcontainers.org/lxd/introduction/) installed and is the current user a member of the `lxd` group?

If so, you can create a container that mounts the system's root directory within the container and then changes its root directory to the system's root directory, effectively granting `root` access to the system.

Refer to your writeup of [TryHackMe's Anonymous](https://github.com/tgihf/writeups/blob/master/tryhackme/anonymous/anonymous.md) for a straight-forward walkthrough.

Refer to [HackTrick's lxd/lxc group privilege escalation page](https://book.hacktricks.xyz/linux-unix/privilege-escalation/interesting-groups-linux-pe/lxd-privilege-escalation) for more information and walkthroughs.

### 11. Credential Hunting

See [[linux-credential-hunting|here]].

### 12. Automated Privilege Escalation Enumeration

**Enumeration**

- [[linpeas|linpeas.sh (bash)]]
- [[linenum|linenum.sh (bash)]]
- [[linuxprivchecker|linuxprivchecker.py (Python 2 default, 3 available)]]

**Exploit Suggestion**

- [[linux-exploit-suggester|Linux Exploit Suggester]]

### 13. Kernel Exploits

See [[linux-kernel-exploits|here]].

---

## With Administrative Access, Capture and Analyze Network Traffic

See [[tcpdump#Capture Network Traffic|here]].

---

## References

[Conda's Privilege Escalation Maps](https://github.com/C0nd4/OSCP-Priv-Esc)

[sushant747's Linux Privilege Escalation](https://sushant747.gitbooks.io/total-oscp-guide/content/privilege_escalation_-_linux.html)

[PayloadsAllTheThings Linux Privilege Escalation](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Linux%20-%20Privilege%20Escalation.md)

[HackTricks Linux Privilege Escalation](https://book.hacktricks.xyz/linux-unix/privilege-escalation)

[g0tmi1k's Basic Linux Privilege Escalation Blog](https://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/)