# CDK

> An open-sourced container penetration testing toolkit, designed for offering stable exploitation in different slimmed containers without any OS dependency. It comes with useful net-tools and many powerful POCs/EXPs and helps you to escape a container and take over K8s cluster easily.

---

## Evaluate the Current Container for Vulnerabilities

```bash
$PATH_TO_CDK evaluate [--full]
```

---

## List All Available Exploits

```bash
$PATH_TO_CDK run --list
```

---

## Run a Single Exploit

```bash
$PATH_TO_CDK run $EXPLOIT [$ARGS]
```

---

## Auto Exploit

```bash
$PATH_TO_CDK auto-escape
```

---

## Edit a File (`vi`)

```bash
$PATH_TO_CDK vi $PATH_TO_FILE
```

---

## Show Process Information (`ps -ef`)

```bash
$PATH_TO_CDK ps
```

---

## Use Netcat

```bash
$PATH_TO_CDK nc
```

---

## Show Network Interfaces

```bash
$PATH_TO_CDK ifconfig
```

---

## References

[GitHub - cdk](https://github.com/cdk-team/CDK)
