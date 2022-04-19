# Upgrade Reverse Shell

Often when you land a shell on a Linux machine, it will lack some features such as interactivity, tab completion, and the dimensions may be off.

With a shell on a target Linux machine, use one of the following processes to upgrade a lacking shell.

## Python Method

1. On the target shell, spawn a TTY with `python -c 'import pty; pty.spawn("/bin/bash")'`
2. Background the target shell with `Ctrl-z`
3. Print the size of your local terminal with `stty -a |cut -d';' -f2-3 | head -n1`
4. Transfer local hotkeys to the target shell with `stty raw -echo` (this may not work properly if your local shell isn't `bash`)
5. Bring the target shell back to the foreground: `fg`
6. Inside the target shell, adjust the dimensions with `stty rows $ROWS cols $COLUMNS`
7. Add color by exporting the value of the local environment variable `$TERM` to the target shell `$TERM`

## `script` Method

1. On the target shell, spawn a TTY with `script -q /dev/null -c bash`
2. Background the target shell with `Ctrl-z`
3. Print the size of your local terminal with `stty -a |cut -d';' -f2-3 | head -n1`
4. Transfer local hotkeys to the target shell with `stty raw -echo` (this may not work properly if your local shell isn't `bash`)
5. Bring the target shell back to the foreground: `fg`
6. Inside the target shell, adjust the dimensions with `stty rows $ROWS cols $COLUMNS`
7. Add color by exporting the value of the local environment variable `$TERM` to the target shell `$TERM`

---

## References

[BoiteAKlou's Infosec Blog](https://www.boiteaklou.fr/Fully-interactive-reverse-shell.html)
