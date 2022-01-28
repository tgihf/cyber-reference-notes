# [theHarvester](https://github.com/laramies/theHarvester)

> A Python 3 tool for determining an organization's external threat landscape, including emails, names, subdomains, IPs, URLs, and more.

---

## Enumerate `$SOURCE` for `$DOMAIN`'s Information

This attempts to gather ASNs, URLs, LinkedIn users, LinkedIn links, Trello URLs, IPs, email addresses, and hostnames related to `$DOMAIN`.

```bash
theHarvester -d $DOMAIN -b $SOURCE [-l $LIMIT]
```

- `$SOURCE` is a comma-separated list of all the sources to enumerate for information on `$DOMAIN`
	- A list of possible `$SOURCE` values can be found when looking at the tool's help page
- `$LIMIT` is the number of test results (defaults to 500)
