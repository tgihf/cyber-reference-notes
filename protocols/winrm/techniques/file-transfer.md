# File Transfer via WinRM

## Requires an active WinRM session

[[sessions]]

---

## Transfer `SOURCE_PATH` to session `$SESSION` `DESTINATION_PATH`

```powershell
Copy-To -Session $SESSION -Source "$SOURCE_PATH" -Destination "$DESTINATION_PATH"
```