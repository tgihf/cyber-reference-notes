# [Linux Capabilities](https://man7.org/linux/man-pages/man7/capabilities.7.html)

> Starting with kernel 2.2, Linux divides the privileges traditionally associated with a superuser into distinct units known as *capabilities*, which can be independently enabled and disabled. Capabilities are a per-thread attribute.

---

## [Short Description of Each Capability](https://book.hacktricks.xyz/linux-unix/privilege-escalation/linux-capabilities)

---

## List All Binaries with Capabilities

```bash
getcap -r / 2>/dev/null
```
