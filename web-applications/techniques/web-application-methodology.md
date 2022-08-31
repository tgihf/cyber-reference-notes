# Web Application Exploitation Methodology

> This process walks you through everything you should do in order to fully understand and exploit a web application.

## 1. Attack Surface Mapping

1. Interact with the web application through a web application proxy (i.e., [[burpsuite|BurpSuite]])
	- Pay careful attention to the **response headers**
		- Can indicate technology stack, virtual hosts, and more
2. Determine the web application's technology stack: **frontend** and **backend**
	- [[wappalyzer]]
	- Response headers
3. **(Optional)** Perform [[path-discovery|automated path discovery]]
4. **(Optional)** Perform [[virtual-host-discovery|automated virtual host discovery]]

## 2. Exploitation

1. **Known exploitation**: Search for a known exploit for the technology stack
2. **Custom exploitation**: For each of the web application's paths (pages):
	- For each user input on the path (page):
		- Scrutinize the web application's behavior in response to the user input for the following vulnerabilities:
			- **Server-Side Vulnerabilities**
				- [ ] [[sql-injection|SQL injection]]
				- [ ] [[os-command-injection|Command injection]]
				- [ ] [[directory-traversal|Directory traversal]]
				- [ ] [[file-inclusion|File inclusion]]
				- [ ] [[file-uploads|File uploads]]
				- [ ] [[server-side-request-forgery|Server-side request forgery (SSRF)]]
				- [ ] [[server-side-template-injection|Server-side template injection (SSTI)]]
				- [ ] [[xml-external-entity-injection|XML external entity (XXE) injection]]
				- [ ] [[business-logic-flaws|Business logic flaws]]
				- [ ] [[information-disclosure|Information disclosure]]
				- [ ] [[prototype-pollution|Prototype pollution]]
				- [ ] [[requesting-splitting|Request splitting]]
			- **Client-Side Vulnerabilities**
				- [ ] [[cross-site-scripting|Cross-site scripting (XSS)]]
				- [ ] [[cross-site-request-forgery|Cross-site request forgery (CSRF)]]
				- [ ] [[clickjacking|Clickjacking]]
				- [ ] [[prototype-pollution|Prototype pollution]]
				- [ ] [[requesting-splitting|Request splitting]]
3. Does the web application attempt to enforce authentication and authorization? How so?
	- Follow the process [[exploiting-authentication#Authentication Exploitation Process|here]] to understand and potentially exploit the **authentication** process
	- Follow the process [[authorization#Authorization Access Control Exploitation Process|here]] to understand and potentially exploit the **authorization** process
