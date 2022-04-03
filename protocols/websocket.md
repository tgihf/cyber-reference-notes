# WebSocket

> WebSocket is an application-layer protocol formally standardized by the IETF as RFC 6455 in 2011. A WebSocket is a bi-directional, full duplex communications protocol initiated over HTTP. They are commonly used in modern applications for streaming data and other asynchronous traffic.

---

## Initiating a WebSocket Connection

### Step 1. The WebSocket API

Generally a WebSocket connection is initiated in client-side JavaScript using the [WebSocket API](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API).

To initiate an unencrypted WebSocket connection you create a `WebSocket` object with a `ws` URL:

```javascript
let unencrypted_ws = new WebSocket("ws://tgihf.click/chat");
```

To initiate a encrypted WebSocket connection over TLS you create a `WebSocket` object with a `wss` URL:

```javascript
let encrypted_ws = new WebSocket("wss://tgihf.click/chat");
```

### Step 2. WebSocket Handshake over HTTP

To establish the connection, the browser and the server perform a WebSocket handshake over HTTP. The browser issues a WebSocket handshake request like the following:

```http
GET /chat HTTP/1.1
Host: normal-website.com
Sec-WebSocket-Version: 13
Sec-WebSocket-Key: wDqumtseNBJdhkihL6PW7w==
Connection: keep-alive, Upgrade
Cookie: session=KOsEJNuflw4Rd9BDNrVmvwBF9rEijeE2
Upgrade: websocket
```

If the server accepts the connection, it will issue a response like the following:

```http
HTTP/1.1 101 Switching Protocols
Connection: Upgrade
Upgrade: websocket
Sec-WebSocket-Accept: 0FFP+2nmNIf/h+4BP36k9uzrYGk=
```

- In both the request and the response, the `Connection` and `Upgrade` headers indicate this is a WebSocket handshake.
- The `Sec-WebSocket-Version` request header specifies the WebSocket protocol version that the client wishes to use (this is typically 13).
- The `Sec-WebSocket-Key` request header contains a base64-encoded random value which should be randomly generated in each handshake request.
- The `Sec-WebSocket-Accept` response header contains a hash of the `Sec-WebSocket-Key` value concatenated with a specific string defined in the protocol specification. This is done to prevent misleading responses from misconfigured servers or caching proxies.

Once this handshake is complete, the WebSocket connection has been initiated and remains open for communications.

---

## Sending a Message over a WebSocket Connection

Once a WebSocket connection has been established, messages can be sent asynchronously in either direction by the client or server.

To send a message over an initiated WebSocket connection you would continue using the [JavaScript WebSocket API](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API), like so:

```javascript
// encrypted_ws was instantiated earlier
encrypted_ws.send("Hello, World!");
```

The WebSocket standard doesn't specify a particular message format, so you can send a string in whatever format you want. Most modern web applications will serialize their messages into JSON strings and send those.

---

## References

[PortSwigger Web Security Academy - What are WebSockets?](https://portswigger.net/web-security/websockets/what-are-websockets)

[MDN - The WebSocket API](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API)

[Wikipedia - WebSocket](https://en.wikipedia.org/wiki/WebSocket)
