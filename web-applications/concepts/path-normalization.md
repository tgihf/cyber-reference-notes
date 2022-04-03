# Path Normalization

> Path normalization refers to the way in which various web technologies parse URLs.

---

## Path Normalization Vulnerabilities

Different web technologies (servers, reverse proxies, etc.) normalize URL paths differently. For example, the following table describes how different web technologies normalize the URL `http://example.com/foo;name=orange/bar/` (credit [here](https://i.blackhat.com/us-18/Wed-August-8/us-18-Orange-Tsai-Breaking-Parser-Logic-Take-Your-Path-Normalization-Off-And-Pop-0days-Out-2.pdf)):

| Technology | Normalized Path |
| --- | --- |
| Apache | `/foo;name=orange/bar/` |
| Nginx | `/foo;name=orange/bar/` |
| IIS | `/foo;name=orange/bar/` |
| Tomcat | `/foo/bar/` |
| Jetty | `/foo/bar/` |
| WildFly | `/foo/` |
| WebLogic | `/foo/bar/` |

When two or more web technologies are used together, an attacker may be able to exploit their inconsistent path normalization logic to access unauthorized paths.

For example, given the above table, consider a web application that consists of a Tomcat server sitting behind an Nginx reverse proxy. The web application designer is using the Nginx reverse proxy to forbid access to the Tomcat's `/admin/dashboard`, to prevent external users (who will go through the reverse proxy) from accessing it.

An external attacker submits a request to the path `/admin;name=orange/dashboard`. Nginx receives this request, normalizes the path as `/admin;name=orange/dashboard`, and since it isn't equal to `/admin/dashboard`, passes it along to the Tomcat web server. The Tomcat web server receives the request, normalizes the path as `/admin/dashboard`, and returns the corresponding administrative dashboard.

---

## Path Normalization to Directory Traversal in Nginx & Tomcat

When Nginx normalizes a URL whose path contains the string `/..;/`, it forwards it along as is.

When Tomcat encounters a URL whose path contains the string `/..;/`, it normalizes it into the string `/../`.

If you are attacking a web application consisting of a Tomcat web server sitting behind an Nginx reverse proxy and if the Tomcat web server is relying on the Nginx reverse proxy to prevent [[directory-traversal|directory traversal]] attacks, this normalization inconsistency can be abused to perform such attacks.

---

## References

[Breaking Parser Logic! - Orange Tsai, BlackHat 2018](https://i.blackhat.com/us-18/Wed-August-8/us-18-Orange-Tsai-Breaking-Parser-Logic-Take-Your-Path-Normalization-Off-And-Pop-0days-Out-2.pdf)

[Hack the Box Seal - Ippsec, YouTube](https://www.youtube.com/watch?v=wCfztTcioU8&t=945s)
