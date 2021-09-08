# Linux Privilege Escalation

The process of escalating privileges on a Linux machine involves careful enumeration. Work through the following steps for consistency and thoroughness.

---

## 1. Current user

```bash
id
```

---

## 2. `sudo` Commands

If you have a password for the current user, check which commands they can run via `sudo`.

```bash
sudo -l
```

---

## 3. [[capabilities#List All Binaries with Capabilities|Check Binaries with Capabilities]]

---

## 4. Run a Privilege Escalation Enumeration Script

- [linpeas.sh](https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/linPEAS)
	- **TODO**: figure out how to cleanly transfer the `linpeas.sh` output remotely