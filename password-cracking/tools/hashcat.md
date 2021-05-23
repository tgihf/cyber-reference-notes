# [hashcat](https://github.com/hashcat/hashcat)

> The world's fastest and most advanced password recovery utility, supporting five unique modes of attack for over 300 highly-optimized hashing algorithms. hashcat currently supports CPUs, GPUs, and other hardware accelerators on Linux, Windows, and macOS, and has facilities to help enable distributed password cracking.

## Hash Files

- Plain text files with one hash per line

```txt
6f1ed002ab5595859014ebf0951522d9
bc13e533f78f5ab4ccbc8bdb0fa46709
cba47c96226f91b8fd08c49cf84114e1
...[SNIP]...
```

## Modes

- Look through example hashes to identify the **mode** integer

```bash
hashcat --example-hashes | less
```

## Rulesets

- Example rulesets can be found in `/usr/share/hashcat/rules/`
- Recommended: `/usr/share/hashcat/rules/best64.rule`


## Offline Dictionary attack

```bash
hashcat -m $MODE $HASH_FILE $WORDLIST [-r $RULESET]
```

```bash
hashcat -m 0 md5-hashes.txt rockyou.txt -r /usr/share/hashcat/rules/best64.rules
```

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