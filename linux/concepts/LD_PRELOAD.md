# [LD_PRELOAD](https://man7.org/linux/man-pages/man8/ld.so.8.html)

> An environment variable that contains a list of additional, user-specified, ELF shared objects to be loaded before all others. This feature can be used to selectively override functions in other shared objects.

---

## `sudo` `LD_PRELOAD` Privilege Escalation

If a user retains the `LD_PRELOAD` environment variable value when running `sudo` commands, they can execute an arbitrary shared object file as the target user of the `sudo` command.

See [[sudo#LD_PRELOAD Exploitation|here]] for more details.

---

## References

[Linux ld.so Man Page](https://man7.org/linux/man-pages/man8/ld.so.8.html)
