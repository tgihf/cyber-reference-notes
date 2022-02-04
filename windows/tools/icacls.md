# [icacls](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/icacls)

> [[windows/tools/cmd/cmd|cmd]] tool for reading and writing a Windows object's [[acls|ACL]].

---

## View an Object's DACL

```cmd
icacls $PATH_TO_FILE_OR_FOLDER
```

---

## Create a ACE on a File

```batch
icacls $FILE_PATH /grant "$USERNAME":($PERM)
```

To grant `$USERNAME` full control, `$PERM` should be `F`.

`$PERM` is a comma-separated list of permissions. A list of possible values can be found on Microsoft's [icacls](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/icacls) documentation.

---

## Remove a User's ACE On a File

```batch
icacls $FILE_PATH /remove "$USERNAME"
```
