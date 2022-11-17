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

---

## Offline dictionary attack against a PGP private key file

Convert the PGP private key file into a format `john` can crack.

```bash
gpg2john $PATH_TO_PGP_PRIVATE_KEY_FILE
```

Save the resultant hash to a file and crack it as normal.

```bash
john --wordlist=$PATH_TO_PASSWORD_LIST $PATH_TO_CONVERTED_PGP_PRIVATE_KEY_FILE
```

---

## Offline dictionary attack against a password-protected ZIP

Convert the password-protected ZIP file into a format `john` can crack.

```bash
zip2john $PATH_TO_ZIP_FILE
```

Save the resultant hash to a file and crack it as normal.

```bash
john --wordlist=$PATH_TO_PASSWORD_LIST $PATH_TO_CONVERTED_ZIP_HASH_FILE
```

---

## Offline dictionary attack against a KeePass database file (`.kdbx`)

Install KeePass tools like `keepass2john`.

```bash
apt install kpcli
```

If the KeePass databsae file is only protected by a master password hash, use `keepass2john` to extract that master password hash into `$OUTPUT_FILE`.

```bash
keepass2john $KDBX_FILE > $OUTPUT_FILE
```

If the KeePass database file is protected by a credential file and a master password, extract the master password hash into `$OUTPUT_FILE`.

```bash
keepass2john -k <file-password> $KDBX_FILE > $OUTPUT_FILE
```

Crack the master password hash.

```bash
john --wordlist=$PATH_TO_WORDLIST $OUTPUT_FILE
```
