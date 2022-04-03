# [Securing Authentication](https://portswigger.net/web-security/authentication/securing)

---

## Force the use of HTTPS

Make sure your entire application, from the login process throughout, leverages HTTPS. Redirect any HTTP attempts to HTTPS.

## Prevent [[username-enumeration|Username Enumeration]]

Don't allow usernames or email addresses to be exposed in publicly accessible profiles or reflected in HTTP responses. Use identical, generic error messages for existing and non-existing usernames and make sure the messages really are identical. Return the same HTTP error code with each login request and make response times as indistinguishable as possible.

## Enforce a Sensible Password Policy

Ensure users aren't using passwords from popular wordlists. Encourage them to use long, randomized passwords managed by a password manager.

## Implement Robust [[web-applications/techniques/brute-forcing|Brute-Force]] Protection

Implement strict, IP-based user rate limiting that requires the user to complete a CAPTCHA test with every login attempt after a certain number of failed attempts. Keep proxies in mind as you attempt to prevent an attacker from side-stepping the IP-based protection.

## Triple Check the Authentication Logic

Throughly test all [[exploiting-authentication|common points of vulnerability in authentication]] to ensure the logic is rock solid. A simple logic error can allow the entire process to be bypassed. Pay just as much attention to [[persistent-login-cookies|persistent login cookies]], the [[password-reset-feature|password reset feature]], and the [[changing-a-users-password|change user password feature]] as you do to the [[password-based-logins|password-based login]] and any [[multi-factor-authentication|multi-factor authentication]].
