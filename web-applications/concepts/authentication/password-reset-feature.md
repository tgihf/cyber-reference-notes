# Password Reset Feature

---

## Overview

Users are humans, and humans are forgetful. For this reason, a feature to reset a forgotten password is common among web applications. Much emphasis needs to be placed on securing this feature, though, as it allows users to bypass the standard authentication flow. There are different ways this feature is implemented in practice, each method with varying degrees of vulnerability.

---

## Resetting Passwords via Email

This comes in two flavors: (1) the web application sends the forgotten password itself to the user or (2) the web application generates a new password and sends it to the user.

The first of these techniques is not very secure, especially if the application doesn't take any effort to invalidate the password after a certain amount of time has passed since the request was sent. Email isn't the place where persistent sensitive information should be stored, and if an attacker was able to read the user's password in their email, they'd have access to the account, even months after the fact.

The second technique is better than the first, depending on the implementation. It's critical that the newly generated password have the following characteristics:

1. Tied to *one particular user account* in a way that prevents it from being reused for other user accounts
		- Server randomly generates password and associates it with the user account in the backend (via a database, for instance)
2. Random
3. Temporary

---

## Resetting Passwords via a URL

A more modern method of resetting a password is to send the user a unique URL (generally via email) that takes them to a page that allows them to reset their password. The URL will contain a query parameter token value that should have the following characteristics:

1. Tied to *one particular user account* in a way that prevents it from being reused for other user accounts
	- For example:
		- Server randomly generates token and associates it with the user account in the backend (via a database, for instance)
		- Server embeds username into JWT that is signed with server-side secret or private key.
2. Expire to prevent it from being replayed by someone else later
	- For example
		- Randomly generated token is stored in database when expiration time
		- Expiration time `exp` stored in JWT
3. Doesn't reveal sensitive account information
	- For example, `base64(username:password)`
4. Long enough to thwart brute-forcing attempts

### Example

For this to happen on the server-side, the server randomly generates a new token, adds to it a database table with the username its associated with and an expiration date, and sends the email to the user with the token as a query parameter of the URL (i.e., `https://tgihf.click/forgot-password?token=ce5fde34bbb00cec90a7153233874eec`). When the user clicks on the link, a `GET` request is sent to `/forgot-password` with the token. The server looks up the token in the database, sees that it exists and hasn't expired, and renders a change password form for the user to change the user's password who was associated with the token. The token is embedded within the form to ensure that the user is only able to change the password of the user associated with the token. This whole process can happen without the need of a database by using a [[brute-forcing/techniques/jwt|JWT]].

### Does the application actually make sure the reset token is also submitted with the reset form?

If not, if you can create a legitimate account and intercept the request to change its password, you can remove the token and redirect it to the target username (if the target username is a parameter in the body, per say).

See [PortSwigger Web Security Academy Lab - Password reset broken logic](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/authentication/vulnerabilities-in-other-authentication-mechanisms/12%20-%20Password%20reset%20broken%20logic.md) for an example of this.

---

## [Password Reset Poisoning](https://portswigger.net/web-security/host-header/exploiting/password-reset-poisoning)

