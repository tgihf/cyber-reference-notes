# [swaks](https://github.com/jetmore/swaks)

> Swiss Army Knife for SMTP. A featureful, flexible, scriptable, transaction-oriented SMTP interaction tool.

---

## Send email

- `$STMP_SERVER`
	- Hostname or IP address

```bash
swaks --to $TO_EMAIL_ADDRESS --from $FROM_EMAIL_ADDRESS --header "Subject: $SUBJECT" --body "$BODY" --server $STMP_SERVER_ [--attach @$FILE_PATH]
```
