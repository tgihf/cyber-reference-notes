# socat

> A command line based utility that establishes two directional byte streams and transfers data between them.

---

## TCP Redirection

Redirect all traffic on `$LOCAL_IP`:`$LOCAL_TCP_PORT` to `$REMOTE_HOST_IP`:`$REMOTE_TCP_PORT`.

```bash
socat TCP4-LISTEN:$LOCAL_TCP_PORT,bind=$LOCAL_IP,fork TCP4:$REMOTE_HOST_IP:$REMOTE_TCP_PORT
```

Example: redirect all traffic on my local TCP endpoint `10.11.12.13`:`8000` to the remote TCP endpoint `192.168.10.150`:`80`.

```bash
socat TCP4-LISTEN:8000,bind=10.11.12.13,fork TCP4:192.168.10.150:80
```

See [bluescreenofjeff's Red Team Infrastructure Wiki](https://github.com/bluscreenofjeff/Red-Team-Infrastructure-Wiki#iptables-for-http).

---

## UDP Redirection

Redirect all traffic on the UDP endpoint `localhost`:`$PORT` to the UDP endpoint `$REMOTE_HOST_IP`:`$PORT`.

```bash
socat udp4-recvfrom:$PORT,reuseaddr,fork udp4-sendto:$REMOTE_HOST_IP; echo -ne
```

Example: redirect all traffic on my local UDP endpoint `localhost`:`53` to the remote TCP endpoint `192.168.10.150`:`53`.

```bash
socat udp4-recvfrom:53,reuseaddr,fork udp4-sendto:192.168.10.150; echo -ne
```

See [bluescreenofjeff's Red Team Infrastructure Wiki](https://github.com/bluscreenofjeff/Red-Team-Infrastructure-Wiki#socat-for-dns).

## References

[socat Man Page - die.net](https://linux.die.net/man/1/socat)
