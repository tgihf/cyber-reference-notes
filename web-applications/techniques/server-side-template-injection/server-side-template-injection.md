# Server-Side Template Injection (SSTI)

HTML template engines (i.e., [Jinja](https://jinja.palletsprojects.com/en/3.0.x/)) allow developers to incorporate dynamic data into static HTML templates.

Server-side template injection (SSTI) is a vulnerability in which a web application inserts unsanitized user input directly into an HTML rendering template, **instead of passing it in as data**. If an attacker inputs a valid statement from the templating language, when the web application renders the template, it will execute the statement, allowing the attacker to execute limited or arbitrary code.

Most templating engines only allow the execution of the uninteresting subset of the programming language, but clever ways of referencing functions (generally via inheritance) can be exploited to enumerate the system's backend, read files, and execute code.

---

## Server-Side Template Injection Methodology

1. Detect the vulnerability
	- The string `${{<%[%'"}}%\` will likely cause an error in most templates because it contains characters key to most templating engines
		- Input it and see if it causes an exception or if you lose some of the characters in the rendering
			- The exception may indicate the templating engine
			- The characters you lose are likely indicators of the templating engine
		
2. Identify the templating engine
	- Determine the backend templating engine syntax. Manually test different templating engine syntaxes, using a tree like the following:

![[Pasted image 20220222132902.png]]

3. Understand the injection context
	- With an understanding of the templating engine, try to understand exactly what context you're injecting into
		- *Code context*: you're injecting into an existing template statement. Unless you're adding more template strings, there's no need to add template delimeters here. If you are adding more template strings, consider whether you'll need to close off the final delimeter
			- i.e., `<h1>Welcome back, {{ $INJECTION }}!</h1>`
		- *Plaintext context*: you're not injecting into an existing template statement. You'll need to add your own template delimeters here.
			- i.e., `<h1>Welcome back, $INJECTION!</h1>`

4. Exploit the vulnerability
	- Read the templating engine's documentation to gain an understanding of how it works
		- Read the "Security Implications" section if it exists
	- Research known SSTI exploitation methods for that particular templating engine
	- Determine built-in functions that are usable in the template
	- Determine developer-supplied functions that are usable in the template
	- Craft an attack chain to achieve your objective

---

## Flask/Jinja Go-To SSTI Attack Chain

Flask's [url_for()](https://flask.palletsprojects.com/en/2.0.x/api/#flask.url_for) function is available within all Jinja templates and can be leveraged to consistently execute functions in Python's `os` module.

```python
url_for.__globals__.os.popen("$COMMAND").read()
```

---

## References

[PortSwigger Web Security Academy](https://portswigger.net/web-security/server-side-template-injection)

[HackTricks - SSTI (Server Side Template Injection)](https://book.hacktricks.xyz/pentesting-web/ssti-server-side-template-injection)

[Payloads All The Things - Server Side Template Injection](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Server%20Side%20Template%20Injection)

[PwnFunction - Server-Side Template Injections Explained](https://www.youtube.com/watch?v=SN6EVIG4c-0)

[Hack the Box - Bolt](https://app.hackthebox.com/machines/384)
