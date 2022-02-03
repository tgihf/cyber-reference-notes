# Hunting Credentials on a Linux Machine

---

## Process

1. Hunt in the current user's exection history (part of [[linux-situational-awareness#Current User's Execution History|situational awareness]])
2. Hunt in the file system

---

## 1. Hunt in the Current User's Execution History

See [[linux-situational-awareness#Current User's Execution History|situational awareness]].

---

## 2. Hunt in the File System

### "Password" Variations in Files

Recursively search `$DIRECTORY` for the word "PASSWORD." Feel free to try other variations, like "passwd," "pass", or "pwd." With color.

```bash
grep --color=auto -rnw $DIRECTORY -ie "PASSWORD" --color=always 2> /dev/null
```

Do the same as the above, but also search for hidden directories. Without color.

```bash
find $DIRECTORY -type f -exec grep -i -I "PASSWORD" {} /dev/null \;
```

### SSH Keys

Recursively search `$DIRECTORY` for known SSH private key files.

```bash
find $DIRECTORY -name id_rsa 2> /dev/null
```

```bash
find $DIRECTORY -name id_dsa 2> /dev/null
```

Recursively search `$DIRECTORY` for authorized SSH public key files.

```bash
find $DIRECTORY -name authorized_keys 2> /dev/null
```

Recursively search `$DIRECTORY` for files that contain SSH keys (very time consuming).

```bash
grep --color=auto -rnw $DIRECTORY -ie "BEGIN.*PRIVATE KEY" --color=always 2> /dev/null
```

### "Password" Variations in File Names

Find all files whose names' **contain** the word "password."

```bash
locate password
```

```bash
find $DIRECTORY -name password 2> /dev/null
```
