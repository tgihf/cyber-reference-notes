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

## Strings

### Concatenate Strings

```bash
"$foo $bar literals, too"
```

## Arithmetic

```bash
$ n=100
$ ((n=$n+20))
$ echo $n
120
```

## For Loop Structure

### For Each
- Single Line

```bash
for $name in $(cat names.txt); do echo $name; done
```

- Multiline

```bash
for $name in $(cat names.txt); do
    echo $name
done
```

### For i in Range
- Single Line

```bash
for $i in {1..254}; do echo "192.168.1.$i"; done
```

- Multiline

```bash
for $i in {1..254};
    do echo "192.168.1.$i";
done
```

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

## File Transfer

```bash
cat $FILE > /dev/tcp/$REMOTE_IP/$REMOTE_PORT
```
