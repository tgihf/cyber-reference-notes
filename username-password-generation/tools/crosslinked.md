# [CrossLinked](https://github.com/m8r0wn/CrossLinked)

> CrossLinked is a LinkedIn enumeration tool that uses search engine scraping to collect valid employee names from a target organization. This technique provides accurate results without the use of API keys, credentials, or even accessing the site directly. Formats can then be applied in the command line arguments to turn these names into email addresses, domain accounts, and more. *(From the Github repository)*

---

## Find All Users of `$COMPANY` with a Particular `$EMAIL_FORMAT`

```bash
python3 crosslinked.py -f '$EMAIL_FORMAT' $COMPANY_NAME
```

- `$EMAIL-FORMAT` examples:
	- `{first}.{last}@domain.com`
	- `{f}{last}@domain.com`
	- `domain.com\{f}{last}`
- `$COMPANY_NAME`
	- You should manually look up the company on LinkedIn and use the string on the company's page for this
	- Example: `Rendition Infosec`

Output is written to `./names.txt`.
