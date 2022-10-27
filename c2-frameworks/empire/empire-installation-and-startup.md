# Empire Installation & Startup

Empire is installed by default in Kali Linux at `/usr/bin/powershell-empire`.

---

## Start the Empire Server

```bash
$ sudo powershell-empire server [--debug] [--config $CONFIG_YAML] [--restip $IP_TO_BIND_REST_API_TO] [--restport $PORT_TO_BIND_REST_API_TO] [--socketport $PORT_TO_RUN_SOCKETIO_ON] [--username $USERNAME] [--password $PASSWORD]
```

- `$CONFIG_YAML`
	- Default in `/etc/powershell-empire/server/config.yaml`
- `$IP_TO_BIND_REST_API_TO` and `$PORT_TO_BIND_REST_API_TO` default to `0.0.0.0` and `1337`, respectively
- `$PORT_TO_RUN_SOCKETIO_ON` defaults to `5000`
- `$USERNAME` and `$PASSWORD` are used to start the Rest API, instead of pulling it from `empire.db`

---

## Connect to the C2 Server

Start the client.

```bash
sudo powershell-empire client
```

This will attempt to connect to an Empire Server on `localhost`. If this fails, the client will boot up and you can connect to an arbitrary Empire Server with:

```bash
(Empire) > connect $EMPIRE_SERVER_FQDN_OR_IP [--port=$EMPIRE_SERVER_REST_API_PORT] [--socketport=$EMPIRE_SERVER_SOCKETIO_PORT] [--username=$EMPIRE_SERVER_USERNAME] [--password=$EMPIRE_SERVER_PASSWORD]
```

---

## Wipe and Reset the Empire Server

```bash
powershell-empire server --reset
```
