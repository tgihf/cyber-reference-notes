# Multipart Form Upload in Reqwest

This is `reqwest 0.11.10` with the `multipart` feature enabled.

```rust
// File part
let name = "payload.php";
let body = "<?php echo \"Hello, World!\"; ?>";
let mime = "application/x-httpd-php";
let part = reqwest::multipart::Part::text(body)
	.mime_str(mime).unwrap()
	.file_name(name);
let form = reqwest::multipart::Form::new()
	.part("file", part);

let client = reqwest::Client::new();
	.multipart(form);
	.text("foo", "boo") // data part
	.send()
	.await?;
```

---

## References

[reqwest::Multipart](https://docs.rs/reqwest/latest/reqwest/multipart/index.html)

[reqwest::RequestBuilder](https://docs.rs/reqwest/latest/reqwest/struct.RequestBuilder.html)
