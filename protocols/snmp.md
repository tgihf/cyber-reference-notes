# [Simple Network Management Protocol](https://en.wikipedia.org/wiki/Simple_Network_Management_Protocol)

> An Internet Standard protocol for collecting and organizing information about managed devices on IP networks and for modifying that information to change device behavior. Devices that typically support SNMP include cable modems, routers, switches, servers, workstations, printers, and more.

---

## Install Dependencies for SNMP Enumeration

```bash
apt-get install snmp-mibs-downloader
download-mibs
```

---

## SNMP Enumeration

Numerous options here. These are ordered by which tools give the most detailed output.

### `snmpwalk`

```bash
snmpwalk -v $VERSION -c $COMMUNITY_STRING $TARGET_IP .1 > $OUTPUT_FILE
```

- `$VERSION`:
	- 1
	- 2c
- `$COMMUNITY_STRING`:
	- public
	- private community string

### `snmpbw.pl`

```bash
perl snmpbw.pl $TARGET_IP $COMMUNITY_STRING $TIMEOUT_IN_SECONDS $THREADS
```

- `/opt/snmp/snmpbw.pl`
- `$COMMUNITY_STRING`:
	- public
	- private community string
- `$TIMEOUT_IN_SECONDS`: 2
- `$THREADS`: 1

---

## Brute Force SNMP Community Strings

```bash
onesixtyone $COMMUNITY_STRINGS_FILE -c $TARGET_IP -w 100
```

- `$COMMUNITY_STRINGS_FILE`
	- Recommended: `/usr/share/seclists/Discovery/SNMP/common-snmp-community-strings-onesixtyone.txt`
