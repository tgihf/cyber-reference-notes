# [Global regular expression print (grep)](https://linuxcommand.org/lc3_man_pages/grep1.html)

> Print lines that match patterns.

## Helpful flags
- `-w` Match whole word
- `-i` Case insentiive
- `-n` Include line number in printout
- `-r` Recursive search
- `-v` Inverted match (print lines that don't match)
- `--context=[num]` Print `num` lines of leading and trailing context
- `-c` Only a count of selected lines is written to standard output

---

## Search for a [regular expression](regex) pattern recursively in a directory

```bash
grep -i -n -r "$REGEX" $DIRECTORY
```

---

## Search for a specific string recursively in a directory

```bash
grep -w -n -r "$STRING" $DIRECTORY
```

---

## Search for a [regular expression pattern](regex) in a single file

```bash
grep -i -n "$REGEX" $FILE
```

---

## Search for a specific string in a single file

```bash
grep -w -n "$STRING" $FILE
```
