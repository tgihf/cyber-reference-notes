# find

Search the file system.

---

## Find file by name $NAME recursively from $DIRECTORY

```bash
find $DIRECTORY -name $NAME
```

## List all files owned by user $USER recursively from $DIRECTORY

```bash
find $DIRECTORY -user $USER -ls 2>/dev/null
```

## List all files owned by group $GROUP recursively from $DIRECTORY

```bash
find $DIRECTORY -group $GROUP -ls 2>/dev/null
```

## Find all files that have been modified between $START_DATE and $END_DATE

- `$START_DATE` and `$END_DATE` examples:
	- 2021-03-12
	- 2021-03-22

```bash
find $DIRECTORY -newermt $START_DATE ! -newermt $END_DATE
```
