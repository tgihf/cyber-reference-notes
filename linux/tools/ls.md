# ls

List files.

## Show full lSO timestamp of entries

- If the nanoseconds of the timestamp is `000000000`, it was placed there by the package manager.
- Conversely, if the nanoseconds of the timestamp isn't `000000000`, it was placed there by a user.

```bash
ls -lt --time-style=full-iso
```

#timestamp-forensics