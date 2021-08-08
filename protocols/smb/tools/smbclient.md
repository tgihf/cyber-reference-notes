# smbclient

> SMB interaction.

## Connect to and browse an SMB share $SHARE on $TARGET

```bash
smbclient -U [$DOMAIN/]$USERNAME //$TARGET/$SHARE
```

## Connect to and browse anonymous SMB share $SHARE on $TARGET

```bash
smbclient [-U $USERNAME] //$TARGET/$SHARE
```

- Since this is an anonymous login, `$USERNAME` can be anything. If unspecified, it will default to the current username.
- You may be prompted for a password. Just hit enter.