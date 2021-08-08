# [hashcat](https://github.com/hashcat/hashcat)

> The world's fastest and most advanced password recovery utility, supporting five unique modes of attack for over 300 highly-optimized hashing algorithms. hashcat currently supports CPUs, GPUs, and other hardware accelerators on Linux, Windows, and macOS, and has facilities to help enable distributed password cracking.

---

## Hash Files

- Plain text files with one hash per line

```txt
6f1ed002ab5595859014ebf0951522d9
bc13e533f78f5ab4ccbc8bdb0fa46709
cba47c96226f91b8fd08c49cf84114e1
...[SNIP]...
```

---

## Modes

- Look through example hashes to identify the **mode** integer

```bash
hashcat --example-hashes | less
```

---

## Rulesets

- Example rulesets can be found in `/usr/share/hashcat/rules/`
- Recommended: `/usr/share/hashcat/rules/best64.rule`

---

## Offline dictionary attack against a file of hashes

```bash
hashcat -m $MODE $HASH_FILE $WORDLIST [-r $RULESET]
```

```bash
hashcat -m 0 md5-hashes.txt rockyou.txt -r /usr/share/hashcat/rules/best64.rules
```


---

## Offline dictionary attack against a particular hash

```bash
hashcat -m $MODE -a 0 $HASH $WORDLIST [-r $RULESET]
```

```bash
hashcat -m 1800  -a 0 bdd04d9bb7621687f5df9001f5098eb22bf19eac4c2c30b6f23efed4d24807277d0f8bfccb9e77659103d78c56e66d2d7d8391dfc885d0e9b68acd01fc2170e3 rockyou.txt -r /usr/share/hashcat/rules/best64.rules
```

---

## Offline dictionary attack against a particular hash with salt

```bash
hashcat -m $MODE -a 0 $HASH:$SALT $WORDLIST [-r $RULESET]
```
```bash
hashcat -m 1710 -a 0 6d05358f090eea56a238af02e47d44ee5489d234810ef6240280857ec69712a3e5e370b8a41899d0196ade16c0d54327c5654019292cbfe0b5e98ad1fec71bed:1c362db832f3f864c8c2fe05f2002a05 /root/wordlists/SecLists/Passwords/Leaked-Databases/rockyou.txt
```

---

## Generate a wordlist by applying a rule set to  a particular password

```bash
$ echo "PleaseSubscribe!" > password.txt
$ hashcat --stdout password.txt -r $RULESET
PleaseSubscribe!
!ebircsbuSesaelP
PLEASESUBSCRIBE!
pleaseSubscribe!
PleaseSubscribe!0
PleaseSubscribe!1
PleaseSubscribe!2
PleaseSubscribe!3
...[SNIP]...
```