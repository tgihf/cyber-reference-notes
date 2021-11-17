# [pypykatz](https://github.com/skelsec/pypykatz)

> A partial [[mimikatz|Mimikatz]] implementation in Python.

---

## Installation

```bash
pip3 install pypykatz
```

---

## Parse an LSASS Minidump

```bash
pypykatz lsa minidump $PATH_TO_LSASS_MINIDUMP_FILE
```

---

## Parse a SAM Registry File

Requires both the `SAM` registry file and the `SYSTEM` registry file.

```bash
pypykatz registry --sam $PATH_TO_SAM_REGISTRY_FILE $PATH_TO_SYSTEM_REGISTRY_FILE
```
