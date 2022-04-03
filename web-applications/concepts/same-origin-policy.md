# Same Origin Policy (SOP)

The Same Origin Policy (SOP) is a browser-level security control which dictates how resources (i.e., HTML documents and JavaScript scripts) served by one **origin** can interact with resources (i.e., documents, endpoints) from some other **origin**. The SOP essentially prevents documents and scripts running under one **origin** from **reading** data from another **origin**.

Notice the emphasis on **reading**. According to the SOP, a resource from one origin can still **make** [[same-origin-policy#What is a simple request|simple requests]] to other origins, it just can't **read** the responses.

What makes a "simple request?" See [[same-origin-policy#What is a simple request|here]].

For example, a script served by `http://malicious.tgihf.click` can **send** an HTTP `POST` request to `http://facebook.com/user/delete` with an arbitrary body. However, it can't **read** the response. This is the basis behind [[cross-site-request-forgery|CSRF attacks]].

The SOP sets a very strict, secure baseline. But don't most modern web applications rely on client-side JavaScript to interact with various cross-origin APIs to dynamically construct their views? They do. If SOP alone dictated how resources are shared between origins, this would be impossible. However, [[cross-origin-resource-sharing|cross-origin resource sharing (CORS)]] gives web application developers the ability to relax the SOP to allow for this kind of behavior.

---

## What is an "origin?"

The origin of a resource is decided by three unique components:

1. Protocol (i.e., `http://`)
2. Hostname (i.e., `tgihf.click`)
3. Port (i.e., `80`)

For two resources to come from the same "origin," they must each come from URLs that have the same values for these three components.

---

## What is a simple request?

An HTTP request that meets all the following conditions:

- One of the allowed methods:
	- `GET`
	- `HEAD`
	- `POST`
- Only these headers can be manually set:
	- `Accept`
	- `Accept-Language`
	- `Content-Language`
	- `Content-Type`
- The only type/subtype combinations allowed for the media types specified in the `Content-Type` header are:
	- `application/x-www-form-urlencoded`
	- `multipart/form-data`
	- `text/plain`
- JavaScript specificities:
	- If the request is made using an `XMLHttpRequest` object, no event listeners are registered on the object returned by the `XMLHttpRequest.upload` property used in the request
	- No `ReadableStream` object is used in the request

---

## References

[StackExchange](https://security.stackexchange.com/questions/157061/how-does-csrf-correlate-with-same-origin-policy)

[MDN - Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)
