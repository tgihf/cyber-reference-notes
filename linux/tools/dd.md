# dd

---

## Read in Binary File

```bash
dd if=$FILE_PATH bs=$BLOCK_SIZE skip=$NUM_BLOCKS_TO_SKIP count=$NUM_BLOCKS_TO_READ [of=$OUTPUT_FILE]
```

- `$BLOCK_SIZE`: number of bytes per block
	- Set to `1` if you want bytes as the unit
- If `of` isn't specified, outputs to `stdout`
