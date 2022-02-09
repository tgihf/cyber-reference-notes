# Error Handling in `rust`

---

## Unwrap the Result if `Ok`, `panic!` if `Err`

```rust
let unwrapped = function_that_returns_a_result().unwrap();
```

---

## Unwrap the Result if `Ok`, `panic!` with `$ERROR_MESSAGE` if `Err`

```rust
let unwrapped = function_that_returns_a_result().expect("$ERROR_MESSAGE");
```

---

## Unwrap the Result if `Ok`, `return` Wrapped Error if `Err`

```rust
let unwrapped = function_that_returns_a_result()?;
```

---

## Unwrap the Result if `Ok`, Do Something with Error if `Err`

```rust
let unwrapped = function_that_returns_a_result().unwrap_or_else(|err| {
	// Do something
	
	// Example:
	eprintln!("Application error: {err}");
	process::exit(1);
});
```

---

## Do Something if `Err`, but Ignore `Ok`

```rust
if let Err(err) = function_that_returns_a_result() {
	//Do something
	
	// Example
	eprintln!("Application error: {err}");
	process::exit(1);
}
```

---

## Do Something if Result is `Ok` or `Err`

```rust
match function_that_returns_a_result() {
	Ok(result) =>	// Do something with result
	Err(err) => 	// Do something with err
}
```
