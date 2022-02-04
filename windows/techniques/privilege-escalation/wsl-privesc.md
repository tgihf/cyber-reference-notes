# Windows Subsystem for Linux (WSL) Privilege Escalation

---

## WSL Guest `root` Shell & Administrative Host Filesystem Access

WSL distributions often mount the host filesystem, making it available within the guest distribution. If you have administrative (i.e., `root`) privileges in the guest distribution, you may be able to perform administrative actions on the host filesystem.

1. Find `bash.exe` and `wsl.exe` on the host.

- [[where#Recursively Find a File on the Filesystem by Name]]

2. Drop into a shell on the guest distribution.

With `bash.exe`:

```batch
$PATH_TO_BASH_EXE
```

With `wsl.exe`, to execute `$COMMAND` on the guest:

```batch
$PATH_TO_WSL_EXE $COMMAND
```

3. Elevate to `root` if you're not already there.

4. Check the user's [[linux-situational-awareness#Current User's Execution History|execution history]].

5. Check if the host filesystem is mounted and explore it.

---

## WSL Guest Filesystem Access

If you aren't able to drop into a shell on the guest filesystem, you may be able to access it at `C:\Users\%USERNAME%\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs\`.
