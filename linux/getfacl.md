# [getfacl](https://linux.die.net/man/1/getfacl)

> For each file, `getfacl` displays the file name, owner, the group, and the Access Control List (ACL). If a directory has a default ACL, `getfacl` also displays the default ACL. Non-directories cannot have default ACLs.

---

## Determine a File or Directory's Name, Owner, Group, and ACL

```bash
getfacl $PATH_TO_FILE_OR_DIRECTORY
```