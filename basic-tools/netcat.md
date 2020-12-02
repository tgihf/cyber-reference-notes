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
