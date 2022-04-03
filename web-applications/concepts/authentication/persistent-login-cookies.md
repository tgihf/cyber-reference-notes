# Persistent Login Cookies

---

## Overview

A persistent login cookie allows a user to remain authenticated to a web application for an extended amount of time, even after they've closed the browser and stopped using the web application.

Though any web application could theoretically give persistent cookies to all users who authenticate successfully, these types of cookies are most often given to users who check the "Remember Me" or "Keep Me Logged In" box when they login successully.

Since this token affectively allows a user to bypass the entire authentication process, it must have a few characteristics.

---

## Secure Persistent Login Cookie Characteristics

1. Impractical to guess
2. Should not contain account plaintext credentials
3. Be generated with some component of randomness
	- If a hashed concatenation of values (i.e., username and timestamp), should be salted

---

## Exploiting Persistent Login Cookies

If you can create an account on the target web application then you can investigate the composition of your persistent login cookie. If you can't create an account, perhaps exploiting a XSS vulnerability on the web application could yield a valid persistent login cookie for you to explore. Furthermore, if the web application is built using an open source framework, the code that composes the persistent login cookies can be examined.

Once you have a valid persistent login cookie, ask the following questions:

- Is the cookie a mere plaintext concatenation of values (i.e., username and password)?
	- Use those credentials
- Does the cookie appear to be encoded?
	- Decode it
- Does the cookie appear to be hashed?
	- Determine the algorithm used and attempt to brute force the hash

Once you understand the composition of the persistent login cookie, you can begin working towards building a legitimate one to access the target account. When you are submitting requests with cookies to see whether or not they work, be wary of any kind of brute-force protection mechanism that may be in play.

See [PortSwigger Web Security Academy Authentication Lab - Brute-forcing a stay-logged-in cookie](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/authentication/vulnerabilities-in-other-authentication-mechanisms/10%20-%20Brute-forcing%20a%20stay-logged-in%20cookie.md) for an example.