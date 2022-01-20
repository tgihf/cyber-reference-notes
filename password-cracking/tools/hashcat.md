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

[[grep]] through example hashes to identify the **mode** integer.

```bash
hashcat --example-hashes | grep $PATTERN
```

Example hash modes are also [here](https://hashcat.net/wiki/doku.php?id=example_hashes).

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

---

## Offline dictionary attack against an AS-REP message ([[ASREP-roasting|ASREP Roasting]])

```bash
hashcat -m 18200 -a 0 $HASHES $PASSWORD_FILE
```

- `$HASHES` is either a single hash or a file of hashes, one per line.

---

## Offline dictionary attack against a Service Ticket ([[kerberoasting|Kerberoasting]])

```bash
hashcat -m 13100 -a 0 $HASHES $PASSWORD_FILE
```

- `$HASHES` is either a single service ticket or a file of service tickets, one per line.

Example service ticket (paste the whole thing):

```text
$krb5tgs$23$*SQLService$THROWBACK.LOCAL$THROWBACK.local/SQLService*$3ece5128fb36411953413fb06f1041c4$98acd85138e6b22a8ba10d8ddbd7c5686e1292b2d8ea48ba709486917dbd0edcc389d08dfe5d4d7e9385516cc50cf73773a4833a84d601d75c154bfd2622a12326832afa29cbd874160d6efe3cf2cbe07ed1ec7ad27c527ad4d0794bd81ce3d3992eae24ce16f2d1efdc709c4f010823559e2bf411bf2fa24ce8bfc91e1b732fb05f00e8d8ce1265f2a72e8af326af61b6b2a146a1da80712c07d3d56ca28ad983f5df1c5c8936721d5fbfeca0b471f3b415e7610386d8135c88de55e1789aae5a084d9e46a594ac22217ae9e0814a10ef515fb96df4741c90a0c3412d545cd2022d0d6cae784ea4e6b83a4fb9a0eba43a89df2b22318fe3f7b081e1ccee5fd2ff511bf5845c280980d8f1253315fa631514bafe75587913381be38ffda2637de5b0fb706c3b4e216645784dbcbb276ddc8ae774f2ac5bc9d28bb24739138769652d6570a538e93777d26625949f15654b03ca49c7a37063ccf0438a460a8a0ee22822a0f74baef4ca21aeb57fcca956a5bd84eb47ee3f4df1b8a749c164ef5869929c17653da8012172b5d763f28051c361b7e4b41f6bfb7159aa5f67b0449486cebf32cec9dcb9a7295abc4d67da775d2ff8b847813ef81299817c532e7db040d62af4eed1b4069f841660c01bc954afa0bdb9018679a1ad4c65e56a6a3bddf43b1a825828ef14b7fcbcc6e20309a68ef88660aea8fa89aeeeca300d892ede04eb7994981788cdef097a5755b02f31c9e4b1c359b5e10a420a9cae3440360f28c331e05c7a89e68413cfeeaf8f64ecedea3a707df5dbb1a2a960182ef13f091d5ea338e81699b4884eca7d02c4f527bba45cfffe2f16e74c6faba3c9997434cce597d9a0763ca135c44a25da320150db73e28e5b06b593319e03b28f37d2cfb89511bda3cdfe59899e47883f237046c038c94d489948a6877ff22e86893e0a819614858e80062544dbd82ef0f3f4b17aff3462ef6ecd10cbe9748c222f24045806bc0d52cf774972fde57b134f79dde82d586743dedf3584ed682a7c22f175cc419bedbb1273e89bbce14cb40cd3cda6d3c33a52a9e52840fe2ea5e3aecd929ea9da0c174b1f70715436b29e3fa8e0dbf1d97cef84beeccc62ecff256f113fb5ee513fe21cd3c33289d1848384660ac5bac7373bb5ec8d43b9a22f8ccbf1feeb597d0429679df8ea6e6dd63f9f1ecf74e0afecc0fd529e4333d2136df57a0209ed40e0593ccb524065cd4f115465150da5812fb76d7b68a2d2a86ef51247757663cb991f5abde6385151fe30a4d7169de9465d228b45d111d99b7527c3acaecb3eb3cd9466345f3613819ea478efc24822fcd0c17f7fe0464a60299a8c92883ffcd722c53935f7b464704caf77ba9be3ad6eba020038fa37d79033547bf94eec3e76a62263d903249a389b510e558bf6
```

---

## Crack NetNTLMv2 Hashes

```bash
hashcat -m 5600 $HASHES $WORDLIST_FILE [-r $RULE_FILE]
```

- `$HASHES` is either a single hash or a file of hashes, one per line.

Example NetNTLMv2 hash (paste the whole thing):

```bash
PetersJ::THROWBACK:b0dac951f0cf53d4:47CCCA16DED0244B2ADA9A935BCC6AFA:0101000000000000C0653150DE09D20174AA4DE9CAC3DA33000000000200080053004D004200330001001E00570049004E002D00500052004800340039003200520051004100460056000400140053004D00420033002E006C006F00630061006C0003003400570049004E002D00500052004800340039003200520051004100460056002E0053004D00420033002E006C006F00630061006C000500140053004D00420033002E006C006F00630061006C0007000800C0653150DE09D201060004000200000008003000300000000000000000000000002000004B3D6B44D2A3120D60A62BF16DB15214DFFFC9A8A1015D7100D300901CE9C73B0A001000000000000000000000000000000000000900200063006900660073002F00310030002E00350030002E00310039002E00310031000000000000000000
```

---

## Crack MD5 (Unix) Hashes

```bash
hashcat -m 500 $HASHES $WORDLIST_FILE [-r $RULE_FILE]
```

---

## Crack Blowfish (Unix) Hashes

```bash
hashcat -m 3200 $HASHES $WORDLIST_FILE [-r $RULE_FILE]
```

---

## Crack sha256crypt Hashes

```bash
hashcat -m 7400 $HASHES $WORDLIST_FILE [-r $RULE_FILE]
```

---

## Crack sha512crypt Hashes

```bash
hashcat -m 1800 $HASHES $WORDLIST_FILE [-r $RULE_FILE]
```
