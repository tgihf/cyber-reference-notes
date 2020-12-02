# File Transfer with Netcat

## Transfer file from Alice to Bob

Set up a Netcat listener on Bob's machine to receive the file.

```bash
bob: nc -nlvp $LISTEN_PORT > $PATH_TO_SAVE_FILE
```

From Alice's machine, transfer the file to Bob.

```bash
alice: nc -nv $BOB_IP $BOB_PORT < $FILE_TO_TRANSFER
```
