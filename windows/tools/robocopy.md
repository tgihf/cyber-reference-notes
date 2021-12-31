# [robocopy](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy)

> `robocopy` is a signed Windows binary for backing up and copying files.

---

## Copy a File in Backup Mode, Overriding the File's ACLs

This must be executed under an account that has the `SeBackupPrivilege` and `SeRestorePrivilege` privileges. If it is, it will bypass the file's ACLs, allowing the copier to copy any file they want whether they can access to it or not (as long as the file's not in use).

```cmd
$ robocopy /b $SOURCE_FOLDER $DESTINATION_FOLDER $FILE1 [$FILE2] [$FILE_N]
```
