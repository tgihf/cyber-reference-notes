# Interacting with Server Message Block (SMB)

## Activate Virtual Environment

```bash
source /usr/share/smbmap/venv/bin/activate
```

## List SMB Shares

```bash
smbmap -H $TARGET -u $USERNAME [-d $DOMAIN] -p $PASSWORD
```

## Connect and Browse an SMB Share

```bash
smbclient -U $DOMAIN/$USERNAME //$TARGET/$SHARE
```
