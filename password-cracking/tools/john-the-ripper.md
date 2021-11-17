# John the Ripper

---

## Offline dictionary attack against SSH private key encrypted with passphrase

### Convert SSH private key to John's format using [ssh2john](https://github.com/openwall/john/blob/bleeding-jumbo/run/ssh2john.py)

```bash
python2 /usr/share/john/ssh2john.py $SSH_PRIV_KEY > ssh_priv_key.john
```

### Perform the dictionary attack

```bash
john --wordlist=$PATH_TO_WORDLIST ssh_priv_key.john
```

See [this](https://github.com/tgihf/writeups/blob/master/tryhackme/basic-pentesting/basic-pentesting.md) for an example.

---

## Offline dictionary attack against a password hash **containing an emoji**

Simply paste the hash with the emoji into a text file and crack as normal.

```bash
john --wordlist=$PATH_TO_WORDLIST $HASH_FILE
```

Example: [HTB Previse]().

---

## Offline dictionary attack against an AS-REP message

Make sure there are no newlines in the hash.

```bash
john $HASH_FILE --wordlist=$PASSWORD_LIST
```
