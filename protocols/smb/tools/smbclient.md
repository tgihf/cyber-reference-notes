# smbclient

> SMB interaction.

---

## Connect to and browse an SMB share $SHARE on $TARGET

```bash
smbclient -U [$DOMAIN/]$USERNAME //$TARGET/$SHARE
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
