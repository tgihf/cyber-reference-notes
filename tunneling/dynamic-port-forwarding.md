# Dynamic Port Forwarding

> Unlike traditional [[local-port-forwarding|local]] and [[remote-port-forwarding|remote port forwarding]] which creates tunnels between two specified endpoints (address and port pair), dynamic port forwarding leverages a [[socks]] proxy to create a tunnel between a specified endpoint and any other endpoint.

---

## Dynamic Local Port Forwarding

Via **local port forwarding** a client can create a tunnel from its own port `1234` through the server and to a server-accessible host's port `5678`. Any data sent to the client's port `1234` is sent through the server and to the server-accessible host's port `5678` **only**.

Via **dynamic local port forwarding**, a client can create a tunnel from its own port `1234` through the server and to **any server-accessible endpoint**. Any data sent to the client's port `1234` is sent through the server and to the server-accessible endpoint, as specified by the [[socks]] protocol.

---

## Dynamic Remote Port Forwarding

Via **remote port forwarding** a client can create a tunnel from the server's port `1234` through the client and to a client-accessible host's port `5678`. Any data sent to the server's port `1234` is sent through the client and to the server-accessible host's port `5678` **only**.

Via **dynamic remote port forwarding**, a client can create a tunnel from the server's port `1234` through the server and to **any client-accessible endpoint**. Any data sent to the client's port `1234` is sent through the client and to the client-accessible endpoint, as specified by the [[socks]] protocol.
