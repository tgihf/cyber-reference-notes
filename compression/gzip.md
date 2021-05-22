# gzip

## gzip Compress

```bash
$ gzip 'blah.txt'
$ ls
blah.txt.gz
```

## gzip Decompress

```bash
$ gzip -d 'blah.txt.gz'
$ ls
blah.txt
```

## gzip View Contents

```bash
$ gzip -l 'blah.txt.gz'
compressed uncompressed  ratio uncompressed_name
        30            5 -99.9%          blah.txt
```

## gzip Compress via Pipe

```bash
cat blah.txt | zcat > 'blah.txt.gz'
```

## gzip Decompress via Pipe

```bash
cat blah.txt.bz2 | zcat -d > 'blah.txt'
```
