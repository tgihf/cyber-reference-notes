# TCP vs. Pivot Listener

> Cobalt Strike offers two types of TCP listeners: a traditional TCP listener and a Pivot TCP listener.

---

## Traditional TCP Listener

Cobalt Strike's traditional TCP listener is akin to a bind shell.

1. An operator has an existing Beacon on Target A
1. A generic TCP listener is configured with a particular TCP port number
2. A payload is generated and configured to work with that TCP listener
3. When the payload is executed on Target B, Target B begins listening on that TCP port
4. An operator can connect Target A's Beacon to the listening TCP port on Target B using the `connect` command
5. Target B's C2 traffic is forwarded through Target A to and from the C2 server

---

## Pivot TCP Listener

Cobalt Strike's Pivot TCP listener is akin to a reverse shell.

1. An operator has an existing Beacon on Target A
2. A Pivot TCP Listener is condigured on Target A with a particular TCP port number
	- This causes Target A to begin listening on this TCP port number
3. A payload is generated and configured to work with that Pivot TCP Listener
4. When the payload is executed on Target B, Target B connects to the listening TCP port on Target A
5. Target B's C2 traffic is forwarded through Target A to and from the C2 server
