# Clickjacking

> Clickjacking is an interface-based attack in which a malicious website overlays a transparent `iframe` of a legitimate web application over itself, lining up a benign-looking button with a button on the legitimate web application. When the user clicks the benign-looking button, they actually click the button on the legitimate web application, performing some sensitive action.

---

## Clickjacking & CSRF

Clickjacking requires user interaction. [[cross-site-request-forgery|CSRF]] doesn't. Doesn't that make CSRF superior to clickjacking? Why use it at all, then?

Because of CSRF tokens. When implemented correctly, CSRF tokens are a powerful protection mechanism. Since the [[same-origin-policy|same origin policy]] and [[cross-origin-resource-sharing|CORS]] prevent malicious scripts from reading data from other origins, they aren't able to read a form's CSRF token and include it in the form submission.

However, in clickjacking, the `iframe` retrieves the cross-domain web page using the web application's cookie (if it exists). This web page includes the form and its CSRF token. When the user falls for the clickjacking attack, they submit the form with the CSRF token.

In summary, clickjacking's advantage over CSRF is that it can be used to bypass CSRF tokens.

---

## Example Clickjacking Malicious Web Page

When rendered by a victim user, this web page overlays `https://vulnerable-website.com` over its own content at `0.00001` opacity (`0` opacity is often detected by browser clickjacking mechanisms) using the `z-index` attribute. The `width` and `height` attributes are used to precisely position the buttons on top of each other. `#target_website`'s position is `relative` and `#malicious_website`'s is `absolute` so everything is positioned properly despite the device's size.

```html
<head>
	<style>
		#target_website {
			position:relative;
			width:128px;
			height:128px;
			opacity:0.00001;
			z-index:2; 
		}
		#malicious_website {
			position:absolute;
			width:300px;
			height:400px;
			z-index:1;
		}
	</style>
</head>
<body>
	<div id="malicious_website">...web content here... </div>
	<iframe id="target_website" src="https://vulnerable-website.com"></iframe>
</body>
```

---

## Clickjacking Protection Mechanisms

### Browser-Side

Clickjacking attacks are possible whenever the target web application can be framed by a web application from another origin. Many browser-side clickjacking protection mechanisms (also known as frame breaking/busting scripts) attempt to restrict cross-origin framing capabilitities by doing one or more of the following:

- Check and enforce that the current web application window is the main or top window (highest Z index)
- Make all frames visibile
- Prevent clicking on invisible frames
- Intercept and flag potential clickjacking attacks to the user

As effective bypass for these kinds of scripts is to include the `sandbox` attribute in the `iframe` with the `allow-forms` or `allow-scripts` value, being sure to also exclude the `allow-top-navigation` attribute from the `iframe`. This combination neautralizes frame buster/breaking scripts by preventing them from checking if the `iframe` is the top window.

```html
<iframe id="victim_website" src="https://victim-website.com" sandbox="allow-forms"></iframe>
```

### Server-Side

#### `X-Frame-Options`

Web application developers can include the header `X-Frame-Options` in their responses to specify whether other origins can include its web pages in frames on their pages.

`X-Frame-Options: deny` completely prevents any web page, including the web application itself, from including its web pages in a frame.

`X-Frame-Options: sameorigin` prevents web pages from other origins from including it in a frame. Web pages from the web application itself can include its web pages in a frame.

`X-Frame-Options: allow-from $ORIGIN` prevents all web pages except for those from `$ORIGIN` from including its web pages in a frame.

#### `Content-Security-Policy`

Similar to `X-Frame-Options`, web application developers can include the header `Content-Security-Policy` to specify whether other origins can include its web pages in frames on their pages.

`Content-Security-Policy: frame-ancestors 'none'` is similar to `X-Frame-Options: deny`.

`Content-Security-Policy: frame-ancestors 'self'` is similar to `X-Frame-Options: self`.

`Content-Security-Policy: frame-ancestors '$HOSTNAME'` is similar to `X-Frame-Options: allow-from $ORIGIN` except just the hostname is specified, not the protocol as in an [[same-origin-policy#What is an origin|origin]] (i.e., `tgihf.click` instead of `https://tgihf.click`).
