> Create a new user or update default new user information.

---

## Create New User

```bash
useradd $USERNAME [-u $UID] [-g $GID] [-d $PATH_TO_HOME_DIRECTORY] [-s $PATH_TO_DEFAULT_SHELL]
```

- `-u $UID` will autoincrement if unspecified
- `-g $GID` will autoincrement if unspecified
- `-d $PATH_TO_HOME_DIRECTORY` defaults to `/home/$USERNAME`

---

## References

[useradd Man Page](https://linux.die.net/man/8/useradd)
