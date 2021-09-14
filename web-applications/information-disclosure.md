# Information Disclosure

> Web applications often contain misconfigurations or logic flaws that leak sensitive information, such as the application's backend structure, verbose error messages, sensitive application data, user account data, and more.

---

## Detecting Information Disclosure Vulnerabilities

###  Web Crawler Files

Files like `/robots.txt` and `/sitemap.xml` were designed to help web crawlers effectively crawl their site. Though most modern web applications don't include them, when present they can still disclose web application paths for an attacker to analyze for vulnerabilities.

### Directory Listings

Some web servers can be configured to show a directory listing of all resources at a particular path instead of rendering an index page. These are helpful for an attacker because they disclose more of the application's resources that can be analyzed for vulnerabilities.

### Developer Comments

View a web application page's source to determine if the develop left any useful information behind in the HTML comments.

### Error Messages

Pay attention to any error messages you see. They can indiate the following:

- The expected data type and format
- Backend technology stack information
	- Type and version of web server, templating engine, etc.
		- There may be publicly available exploits against the backend technology stack
		- There may be common configuration errors or default credentials associated with the backend technology stack
		- If the backend technology stack is open source, analyze its source code

The differences in error messages may also indicate the presence of other types of vulnerabilities, such as [[sql-injection|SQL injection]] or [[username-enumeration|username enumeration]].