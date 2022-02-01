## Program Structure in `rust`

The idiomatic way to structure a `rust` program is:

- `main.rs` contains only `main`, which is responsible for scrubbing any command line arguments and passing them to `run`, which is the entry point for the program's real logic. It also handles all errors returned from `run`.
- `lib.rs` contains all of the program's logic, including the `run` function

---

## Example Program

This project, `even_or_odd`, determines whether a given number is even or odd. Example usage:

```bash
$ ./even_or_odd 1
Odd!
$ ./even_or_odd -2
Even!
```

```rust
// main.rs
use std::env;
use std::process;

use even_or_odd::NumberArgument;

fn main() {
	
	// Parse arguments
	let args: Vec<String> = env::args().collect();
	let num = NumberArgument(&args).unwrap_or_else(|e| => {
		eprintln!("Error parsing argument: {}", e);
		process::exit(1);
	})
	
	// Run the program's primary logic
	// Generally we'll be prepared to handle errors from run() as well
	even_or_odd::run(num);
}
```

```rust
// lib.rs

pub struct NumberArgument {
	value: i32
}

impl NumberArgument {
	pub new(args: &Vec<String>) -> Result<NumberArgument, Box<dyn Error>> {
		if args.len() < 2 {
			return Err("Not enough arguments");
		}
		let n = s.parse::<i32>()?;
		Ok(NumberArgument { value: n })
	}
}

pub fn run(num: NumberArgument) {
	if is_even(num.value) {
		println!("Even!");
	} else {
		println!("Odd!");
	}
}

fn is_even(x: i32) -> bool {
	x % 2 == 0
}
```

---

## References

[An I/O Project: Building a Command Line Program](https://doc.rust-lang.org/book/ch12-00-an-io-project.html)
