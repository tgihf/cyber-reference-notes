# [MailGun](https://mailgun.com)

> One of the world's largest services for sending, receiving, and tracking emails at any scale. MailGun provides a powerful API for developers to automate email actions.

---

## Verify Source Domain

Ensuring your mail service (MailGun in this case) has verified your source domain goes a long way towards passing [[dkim|DKIM]] checks.

From the main page, navigate to `Sending` -> `Domains` -> `Add New Domain`.

Input the name of your source domain and choose the domain's region. Click `Add Domain`.

On the next page, follow the instructions for adding the relevant records to your domain configuration. You'll need to log in to your DNS provider for this. FYSA, one of these records is a [[dmarc|DMARC]] record.

As you go through the instructions, click `Verify DNS Settings` periodically to have MailGun verify your changes.

To see if the domain has been verified, navigate to `Domains`. It will have a green check beside it.

---

## Obtaining SMTP Credentials

Once your domain has been verified, MailGun should ask you if you want to proceed with SMTP credentials or an API key. If you select SMTP credentials they'll step you through the process you need to follow.

If you haven't received that prompt, you can find the SMTP credentials by navigating to `Sending` -> `Domain Settings` -> `SMTP Credentials`. Make sure the desired domain is selected at the top.

MailGun will have created an SMTP credential with the login `postmaster@$YOUR_DOMAIN`. To retrieve the password, you'll have to reset it. Select `Reset Password`, copy the generated password, and save it somewhere.

This SMTP credential will be the `Username` and `Password` fields of your [[gophish#Sending Profiles|GoPhish sending profile]]. The SMTP server's hostname and port will be the `Host` field of that profile.

Password: `07e9b88e6ceb82ebe0d34666213092fa-c250c684-492723f6`.
