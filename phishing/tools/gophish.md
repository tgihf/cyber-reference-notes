# [GoPhish](https://github.com/gophish/gophish)

> An open-source phishing toolkit designed for businesses and penetration testers. It provides the ability to quickly and easily setup and execute phishing engagements and security awareness training (from the Github).

---

## Installation

### Building from Source

Ensure `go` is [[golang-installation|installed]].

Download the `GoPhish` source.

```bash
go get github.com/gophish/gophish
```

Build the `GoPhish` binary.

```bash
cd ~/go/src/github.com/gophish/gophish
go build
```

The default configuration has `GoPhish`'s admin panel listening only on `localhost`. You want it to be listening on a public interface. In `~/go/src/github.com/gophish/gophish/config.json`, change the `admin_server`'s `listen_url`'s address to a public interface or all interfaces. Change the port as well, if desired.

```json
...[SNIP]...
{
	"admin_server": {
		"listen_url": "0.0.0.0:3333"
		...[SNIP]...
	}
}
```

Start the server with elevated privileges.

```bash
sudo ~/go/src/github.com/gophish/gophish/gophish
```

The username `admin` and a randomly generated password will be printed out. Navigate to the admin interface's URL (it's HTTPS) and use these to login.

As prompted, reset the password. You're good to go.

---

## Web Application Interface

![[Pasted image 20220131151803.png]]

`GoPhish`'s web interface is pretty intuitive. A couple of notes about some of the options:

### Landing Pages

These are static web pages whose links can be embedded directly into the phishing emails you send out. When users click these links, they'll land on these pages.

`GoPhish`'s landing pages are static. Use [[evilginx2]] as a more sophisticated man-in-the-middle-based approach to capturing a user's credentials.

### Sending Profiles

The source data necessary to successfully send the phishes. Describes who the email is going to be coming from.

See [[gophish#Creating a Sending Profile|here]].

---

## Creating a Sending Profile

1. The `From` field is the source email address from the spoofed domain you created. The domain should be verified so you'll pass any [[dmarc|DMARC]] checks. Example: `administrator@phishinglnc.com`.

2. The `Host` field is the FQDN and port of the SMTP server you'll be using to send the email. You should be able to find this in your mail service provider's SMTP settings. Example: `smtp.mailgun.org:587`.

3. The `Username` and `Password` fields are the SMTP credential you were given in your mail service provider's SMTP settings.

How to get these settings for various mail service providers:
- [[mailgun#Obtaining SMTP Credentials|MailGun]]

4. After you've finished setting up the sending profile, you can send a test email to an address you control in order to make sure the profile works. Use [[10minutemail]] for a quick anonymous email address.
