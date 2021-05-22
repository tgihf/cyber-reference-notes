# bzip2

## bzip2 Compress File

```bash
$ bzip2 -z 'blah.txt'
$ ls
blah.txt.bz2
```

## bzip2 Decompress

```bash
$ bzip2 -d 'blah.txt.bz2'
$ ls
blah.txt
```

## bzip2 Compress via Pipe

```bash
cat blah.txt | bzcat -z > 'blah.txt.bz2'
```

## bzip2 Decompress via Pipe

```bash
cat blah.txt.bz2 | bzcat -d > 'blah.txt'
```
