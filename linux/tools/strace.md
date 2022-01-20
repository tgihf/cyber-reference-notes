# [strace](https://man7.org/linux/man-pages/man1/strace.1.html)

> A tool for monitoring and tampering with interactions between user-space applications and the kernel.

---

## Trace a Command's Interactions with the Kernel

```bash
strace $COMMAND 2>&1
```

---

## Looking for Failed Shared Object File Imports

```bash
strace $COMMAND 2>&1 | grep -i -E "open|access|no such file"
```
