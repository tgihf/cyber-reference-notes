# tar

## Create tar Archive with gzip Compression

```bash
tar -zcvf archive.tgz directory/
```

## tar/gzip Decompress

```bash
tar -zxvf archive.tgz
```

## tar/gzip View Contents

```bash
tar -tf archive.tgz
```

## Create tar Archive with bzip2 Compression

```bash
tar -jcvf archive.tbz2 directory/
```

## tar/bzip2 Decompress

```bash
tar -jxvf archive.tbz2
```

## tar/bzip2 View Contents

```bash
tar -jtvf archive.tbz2
```

## tar Decompress

```bash
tar -xvf archive.tar
```

## tar Decompress via Pipe

```bash
cat blah.tar | tar xO -d > 'blah.bin'
```
