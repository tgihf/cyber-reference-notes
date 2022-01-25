# Search Engines

---

## List of Search Engines

- [Google](https://www.google.com/) (US)
	- [Google Advanced Search](https://www.google.com/advanced_search) (US)
- [DuckDuckGo](https://duckduckgo.com/) (US)
- [Bing](https://www.bing.com/) (US)
- [Yandex](https://yandex.com/) (Russian)
- [Baidu](https://www.baidu.com/) (Asian)

---

## Search Engine Operators

Search engine operators allow you to fine-tune your search engine queries.

### `AND`

Return results that contain both the word `wgu` and the word `c958`.

```txt
wgu AND c958
```

### `OR`

Return results that contain either the word `wgu` or the word `c958`.

```txt
wgu OR c958
```

### `-` (NOT)

Return results that contain the word `wgu` but **do not** contain the word `c958` (works for excluding subdomains as well).

```txt
wgu -c958
```

### `""`

Return results that contain the exact phrase `wgu c958`.

```txt
"wgu c958"
```

### `*`

Wildcard character that matches any word or phrase.

```txt
"heath adams" the * mentor
```

### `site`

Only return results on `reddit.com`.

```txt
wgu c958 site:reddit.com
```

Return results from all subdomains of `tesla.com` except for `www.tesla.com`.

```txt
password site:*.tesla.com -www
```

### `filetype`

Only return PDFs that contain the word `password` from `tesla.com`.

```txt
password site:tesla.com filetype:pdf
```

### `intext`

Return all results whose text contains the word `password`.

```txt
intext:password
```

### `intitle`

Return all results whose title contains the word `password`.

```txt
intitle:password
```

### `inurl`

Return all results whose URL contains the word password

```txt
inurl:password
```

---

## References

[TCM Security - Open Source Intellignce (OSINT) Fundamentals](https://academy.tcm-sec.com/p/osint-fundamentals)

[ahrefs - Google Search Operators: The Complete List (42 Advanced Operators)](https://ahrefs.com/blog/google-advanced-search-operators/)
