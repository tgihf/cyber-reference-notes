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
