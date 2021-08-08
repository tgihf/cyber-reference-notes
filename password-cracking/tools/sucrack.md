# [sucrack](https://github.com/hemp3l/sucrack)

> A multithreaded Linux/UNIX tool for brute-force cracking local user accounts via `su`.

## Compilation

```bash
git clone https://github.com/hemp3l/sucrack.git
cd sucrack
./configure
$ ls src/sucrack
sucrack
```

---

## Dictionary attack against user $USERNAME with wordlist $WORDLIST using `su`

```bash
sucrack -u $USERNAME -r $WORDLIST
```