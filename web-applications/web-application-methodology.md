# Web Application Exploitation Methodology

> This process walks you through everything you should do in order to fully understand and exploit a web application.

1. Visit the web application's landing page in a browser through a web application proxy (i.e., [[burpsuite|BurpSuite]])
2. Determine the web application's technology stack: **frontend** and **backend**
	- [[wappalyzer]]
	- Response headers
3. **(Optional)** Perform [[content-discovery|automated content discovery]]
4. **(Optional)** Perform [[virtual-host-discovery|automated virtual host discovery]]
5. For each of the web application's paths (pages):
	- For each user input on the path (page):
		- Scrutinize the web application's behavior in response to the user input for the following vulnerabilities:
			- [ ] [[business-logic-flaws|Business logic flaws]]
			- [ ] [[sql-injection|SQL injection]]
			- [ ] [[os-command-injection|Command injection]]
			- [ ] [[directory-traversal|Directory traversal]]
			- [ ] [[file-uploads|File uploads]]
			- [ ] [[information-disclosure|Information disclosure]]
6. Does the web web application attempt to enforce authentication and authorization? How so?
	- Follow the process [[exploiting-authentication#Process|here]] to understand and potentially exploit the **authentication** process
	- Follow the process [[authorization#Authorization Access Control Exploitation Process|here]] to understand and potentially exploit the **authorization** process
