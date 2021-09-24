# cp

> Copy files and directories.

---

## Abuse Copying a Wildcard to Preserve SUID Permissions (`cp *`)

If you are somehow able to execute `cp * $DESTINATION` with elevated privileges (via `sudo` maybe), it is possible to create a SUID binary with elevated privileges.

First, create the binary in the directory where the `cp * $DESTINATION` command is executed. In this example we'll assume that `cp * $DESTINATION` is being executed in the current directory.

```bash
$ cp /bin/bash tgihf
```

Next, set the binary to executable and SUID.

```bash
$ chmod 4777 tgihf
```

`cp`'s `--preserve=mode` command will preserve a file's mode after the copy. This flag is the key to ensuring the binary remains SUID after being copied.

Create a file named `--preserve=mode` in the current directory.

```bash
$ echo "" > "--preserve=mode"
```

Now execute `cp * $DESTINATION` with elevated privileges. [[bash#Wildcard Behavior|bash's wildcard behavior]] will expand all of the files in the current directory and cause the command `cp --preserve=mode tgihf $DESTINATION` to execute. As a result, this binary will be copied and owned by the user with elevated privileges **and** will retain its SUID mode.
