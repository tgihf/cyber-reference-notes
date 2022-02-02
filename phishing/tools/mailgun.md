# [MailGun](https://mailgun.com)

> One of the world's largest services for sending, receiving, and tracking emails at any scale. MailGun provides a powerful API for developers to automate email actions.

---

## Verify Source Domain

Ensuring your mail service (MailGun in this case) has verified your source domain goes a long way towards passing [[dkim|DKIM]] checks.

From the main page, navigate to `Sending` -> `Domains` -> `Add New Domain`.

Input the name of your source domain and choose the domain's region. Click `Add Domain`.

On the next page, follow the instructions for adding the relevant records to your domain configuration. You'll need to log in to your DNS provider for this.

As you go through the instructions, click `Verify DNS Settings` periodically to have MailGun verify your changes.

To see if the domain has been verified, navigate to `Domains`. It will have a green check beside it.
