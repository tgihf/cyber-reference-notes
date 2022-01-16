# smbclient

> SMB interaction.

---

## Connect to and browse an SMB share $SHARE on $TARGET

```bash
smbclient //$TARGET/$SHARE [-W $DOMAIN] -U $USERNAME
```

---

## Connect to and browse anonymous SMB share $SHARE on $TARGET

```bash
smbclient -U '%' //$TARGET/$SHARE
```

- You may be prompted for a password. Just hit enter.

---

## Connect to and browse SMB share $SHARE on $TARGET with guest session

```bash
smbclient -U 'guest%' //$TARGET/$SHARE
```

---

## Connect to and browse SMB share $SHARE on $TARGET with NTLM hash

```bash
smbclient //$TARGET/$SHARE [-W $DOMAIN] -U $USERNAME [--pw-nt-nash $NTLM_HASH]
```

- `$NTLM_HASH` example: `0ce1cb01ade331cdba32d0e1fba338a1`
