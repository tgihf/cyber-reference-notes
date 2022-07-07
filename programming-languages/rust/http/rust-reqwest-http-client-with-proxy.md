# HTTP Client with Proxy

---

## Asynchronous

```rust
let client = reqwest::Client::builder()
	.proxy(reqwest::Proxy::all("http://127.0.0.1:8080")?)
	.build()?;
```


`.all()` proxies all requests made by the client through `http://127.0.0.1:8080`. Can also use `.http()`, `.https()`, or `.custom()`.

---

[Reqwest - Struct reqwest::Proxy](https://docs.rs/reqwest/latest/reqwest/struct.Proxy.html)

