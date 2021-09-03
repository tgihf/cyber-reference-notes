# Steganography

> The practice of hiding data within other data.

---

## Search for hidden data in a file

```bash
binwalk $PATH_TO_FILE
```

---

## Extract hidden data from a file

```bash
binwalk -e $PATH_TO_FILE
```

---

## Extract hidden data from a file based on headers, footers, and internal data structures

```bash
foremost -i $PATH_TO_FILE
```

---

## Brute force data hidden within a file by [steghide](https://github.com/Paradoxis/StegCracker)

```bash
stegcracker $PATH_TO_FILE $WORDLIST 
```
