# kwprocessor

> [[hashcat|hashcat]] utility for generating custom keyboard walk dictionaries for password cracking. Base characters, keymap, and routes are configurable.

---

## Generate a Dictionary of Keyboard Walks

```bash
kwp64 $BASECHARS $KEYMAP $ROUTES -o $PATH_TO_OUTPUT_FILE
```

- `$BASECHARS` is a `.base` file describing the alphabet of the target language
	- See `kwprocessor/basechars` for examples
- `$KEYMAP` is a `.keymap` file describing the layout of the keyboard
	- See `kwprocessor/keymaps` for examples
- `$ROUTES` is a `.routes` file describing the directions to walk the keyboard in
	- See `kwprocessor/routes` for examples

Some candidate password will be generated multiple times, leading to duplicates in the output file. Be sure to remove all duplicates before leverage the output file in a password attack.

---

## References

[kwprocess GitHub Repository](https://github.com/hashcat/kwprocessor)
