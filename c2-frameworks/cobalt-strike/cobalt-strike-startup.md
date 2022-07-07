# Cobalt Strike Startup

## 1. Start the Team Server

1. Change to the `cobaltstrike/` directory
2. Start the Team Server

```bash
./teamserver $BIND_IP_ADDRESS $OPERATOR_PASSWORD
```

- `$BIND_IP_ADDRESS`: the IP address of the Team Server to bind to (can be `0.0.0.0`)
- `$OPERATOR_PASSWORD`: the password operators will use in the Cobalt Strike client to connect to the Team Server

Note the server's fingerprint.

## 2. Start the Client

1. Run the Cobalt Strike client
2. Enter in the information required to connect to the Team Server
	- Ensure the fingerprint matches the one displayed when starting the Team Server

## 3. Configure Listeners

Be sure to include any redirectors.
