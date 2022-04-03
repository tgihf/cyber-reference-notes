# [Authorization / Access Control](https://portswigger.net/web-security/access-control)

> After a user has proven their identity (authentication), the application must ensure that the user has permission to access the resources and perform the actions they are attempting to (authorization).

---

## Authorization / Access Control Exploitation Process

1. *Thoroughly* understand the web application's authorization mechanism(s)
	- How are users identified?
	- Are requests checked for proper authorization? How does the application check authorization?
2. With a good understanding of the web application's authorization mechanism(s), read through the following sections and see if any of the techniques apply:
	- [[authorization#Vertical Privilege Escalation|Vertical privilege escalation]]
	- [[authorization#Horizontal Privilege Escalation|Horizontal privilege escalation]]
	- [[authorization#Access Control Vulnerabilities in Multi-Step Processes|Access Control Vulnerabilities in Multi-Step Processes]]
	- [[authorization#Referer Based Access Control|Referer-based Access Control]]

---

## Vertical Privilege Escalation

Vertical privilege escalation occurs when a user of one type is able to access resources or functionality that should only be accessible to users of a different, more privileged type.

The classic example of this is of a regular user being able to perform functionality (such as deleting other users) that only administrators should be able to perform.

### Unprotected Functionality

For an application to enforce authorization and prevent vertical privilege escalation, it has to actually perform a server-side check to ensure that the current user has permission to access the resource or perform the action.

Does it? Is it possible to perform the action or access the resource without the "proper" permissions?

Example: [PortSwigger Web Security Academy Access Control Lab - Unprotected admin functionality]().

Does the application have particular functionality whose access is obfuscated? Perhaps this functionality is also unprotected.

Look around the application for references to the obfuscated functionality:
- `/robots.txt`
- `/sitemap.xml`
- HTML source
- JavaScript

Example: [PortSwigger Web Security Academy Access Control Lab - Unprotected admin functionality with unpredictable URL]().

### Protected Functionality, but User Role is User-Controlled

After a user proves their identity (authenticates), the application should issue them a unique identifier (session token or [[web-applications/concepts/authorization/jwt|JWT]]). The user should submit this identifier with every request, and the application should use this idenitifer to determine the requesting user and then allow or deny permission to the resource or functionality based on the user.

How does the application determine the current user's permissions? Is it on the backend, as it should be? Or are the user's roles defined via some user-controllable input, such as a cookie? If so, is it possible to tamper with the cookie to elevate privileges?

Example: [PortSwigger Web Security Academy Access Control Lab - User role controlled by request parameter]().

Is there some sort of a feature that allows you to update the current user account? Perhaps you can also update its role. For example, if administrative users have a `role_id` of 0 and regular users have a `role_id` of 1, is it possible to update your `role_id` to 0?

Example: [PortSwigger Web Security Academy Access Control Lab - User role can be modified in user profile]().

### Authorization Bypass via Platform Misconfiguration

Perhaps the application restricts access to a particular URL path, like `/admin`. If it is sensitive to the `X-Original-URL` or `X-Rewrite-URL` headers, it might be possibe to access the `/admin` path anyways. Consider the following HTTP request:

```http
GET / HTTP/1.1
Host: blah.tgihf.click
User-Agent: curl
X-Original-URL: /admin
```

The application may allow the request to pass through since it is requesting the URL path `/`, but then follow the `X-Original-URL` header value and return the source for the `/admin` URL path. It's a long shot, but apparently useful somewhere.

Example: [PortSwigger Web Security Academy Access Control Lab - URL-based access control can be circumvented]().

Perhaps the application properly enforces authorization on a particular HTTP method and endpoint combination, but not when using a different HTTP method on the same endpoint. For example, the application may enforce authorization for `POST` requests to the `/user/$USER_ID/delete` endpoint, but not enforce authorization for `GET` requests to the `/usr/$USER_ID/delete` endpoint. Again, it's a long shot, but worth realizing that the same endpoints may respond differently based on the HTTP method.

Example: [PortSwigger Web Security Academy Access Control Lab - Method-based access control can be circumvented]().

---

## Horizontal Privilege Escalation

Horizontal privilege escalation occurs when a user of one type is able to access the resource of a user of the same type.

The classic example of horizontal privilege escalation is one user accessing another user's account through the manipulation of some user ID.

Horizontal privilege escalation is often also known as an [[idor|Insecure Direct Object Reference, or IDOR]].

### Manipulating a Predictable User ID

How does the web application identify its users? Is it through a mechanism that is easily predictable, like an identification integer (i.e., an administrator account whose user ID is 0)?

If so, could you leverage this to perform actions as other users? Maybe view data only they should be allowed to access? Does any of the web application's functionality require a user ID input parameter?

See [PortSwigger Web Security Academy Access Control Lab - User ID controlled by request parameter]() for an example.

### Manipulating an Unpredictable User ID

Perhaps the application uses something less predictable than incrementing integers to identify users, like randomly generated GUIDs (i.e. `24b31c53-531e-4fff-97a8-35cda067eaa5`). You're not going to brute force that.

Perhaps the application reveals each user's GUID through a user listing page or an individual user's profile? If you're able to find a GUID, can you leverage it to perform actions as that user? Can you view any data only they should be allowed to access?

See [PortSwigger Web Security Academy Access Control Lab - User ID controlled by request parameter, with unpredictable user IDs]() for an example.

### Data Leakage

If the application properly authorizes each check on the backend, it will likely redirect you somewhere else (maybe a login page) if you attempt to access an unauthorized resource or perform an unauthorized action.

Look at the body of the redirect response though. Does it contain any useful data? Perhaps the web application accidentally returns the requested data? Worth checking out.

See [PortSwigger Web Security Academy Access Control Lab - User ID controlled by request parameter with data leakage in redirect]() for an example.

---

## Access Control Vulnerabilities in Multi-Step Processes

Often times, sensitive actions on a web application require multiple steps. For example, before Github will allow you to delete a repository, you must:

1. Login
2. Pass an MFA check
3. Load and complete the repository deletion form
4. Review and confirm the repository deletion

Ideally, adequate access controls are applied to each of these steps. However, perhaps they're not. Perhaps access controls are applied very well to steps 1-3, but not to #4.

More generally, is it possible to complete any of the steps without completing their predecessor? As a result, can you complete the entire process without actually going through it? Understanding the entire flow is key here.

---

## `Referer` Based Access Control

When a client is redirected to another URL, the `Referer` HTTP header specifies the original URL that redirected them.

Apparently some web applications use the `Referer` header as a means to enforce authorization by ensuring the client first went through a particular URL path (i.e., `/auth`) first. The `Referer` header can be easily forged, rendering this defense useless. If you come across this defense, determine the proper `Referer` and set it to bypass access controls.
