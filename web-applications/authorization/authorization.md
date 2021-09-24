# [Authorization / Access Control](https://portswigger.net/web-security/access-control)

> After a user has proven their identity (authentication), the application must ensure that the user has permission to access the resources and perform the actions they are attempting to (authorization).

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

After a user proves their identity (authenticates), the application should issue them a unique identifier (session token or [[web-applications/authorization/jwt|JWT]]). The user should submit this identifier with every request, and the application should use this idenitifer to determine the requesting user and then allow or deny permission to the resource or functionality based on the user.

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

`TODO`

### Manipulating an Unpredictable User ID

`TODO`

### Data Leakage

`TODO`

---

## Horizontal to Vertical Privilege Escalation

`TODO`
