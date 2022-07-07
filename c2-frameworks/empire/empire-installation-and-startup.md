# Empire Installation & Startup

Empire is installed by default in Kali Linux at `/usr/bin/powershell-empire`.

---

## Start the Team Server

```bash
$ sudo powershell-empire server [--debug] [--config $CONFIG_YAML] [--restip $IP_TO_BIND_REST_API_TO] [--restport $PORT_TO_BIND_REST_API_TO] [--socketport $PORT_TO_RUN_SOCKETIO_ON] [--username $USERNAME] [--password $PASSWORD]
```

- `$CONFIG_YAML`
	- Default in `/etc/powershell-empire/server/config.yaml`
- `$IP_TO_BIND_REST_API_TO` and `$PORT_TO_BIND_REST_API_TO` default to `0.0.0.0` and `1337`, respectively
- `$PORT_TO_RUN_SOCKETIO_ON` defaults to `5000`
- `$USERNAME` and `$PASSWORD` are used to start the Rest API, instead of pulling it from `empire.db`

---

## Connect to the Team Server

Start the client.

```bash
powershell-empire client
```

This will attempt to connect to a Team Server on `localhost`. If this fails, the client will boot up and you can connect to an arbitrary Team Server with:

```bash
(Empire) > connect $TEAMSERVER_FQDN_OR_IP [--port=$TEAMSERVER_REST_API_PORT] [--socketport=$TEAMSERVER_SOCKETIO_PORT] [--username=$TEAMSERVER_USERNAME] [--password=$TEAMSERVER_PASSWORD]****
```

---

## Wipe and Reset the Team Server

```bash
powershell-empire server --reset
```

---

## List Listeners

```bash
(Empire) > listeners
```

---

## Start HTTP Listener

```bash
(Empire) > uselistener http
```

Configure the options. Note that the option `Port` is required.

```bash
(Empire: uselistener/http) > options
```

Start it.

```bash
(Empire: uselistener/http) > execute
```
