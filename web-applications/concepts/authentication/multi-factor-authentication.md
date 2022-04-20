# [Multi-Factor Authentication](https://portswigger.net/web-security/authentication/multi-factor)

> Multi-factor authentication schemes rely on two or more authentication "factors" to prove an identity claim and authenticate the user. There are three major types of authentication factors: Something you know (i.e., password), something you have (i.e., another device), and something you are (i.e., biometrics). Most web application multi-factor authentication schemes rely on the first two.

---

## Something You Have - Authentication Tokens

Authentication tokens are either generated by or sent to another physical device for the purpose of proving you have access to that device. Three types of authentication tokens are generally used today:

1. Dedicated token devices
	- A little device that is solely dedicated to **generating** authentication tokens. For example, an [RSA token](https://www.rsa.com/content/dam/en/data-sheet/rsa-securid-hardware-tokens.pdf).
2. Smartphone device with software-**generated** tokens
	- A smartphone configured with an application that generates authentication tokens. For example, [Duo](https://duo.com/) or [Google Authenticator](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en_US&gl=US).
3. Smartphone device that receives authentication tokens via SMS
	- Self-explanatory. A convenient solution, as all it requires is a mobile device with an active SIM card as opposed to some particular piece of software. This is still a good solution, but not quite as good as #1 or #2 since the device doesn't generate the token itself but instead receives it from somewhere else. If someone is able to get a hold of the target phone's SIM card, they can intercept the authentication token.

---

## Bypassing Two-Factor Authentication

As with any exploit attempt, understanding the behavior of the target system is crucial. Understanding how the target system implements two-factor authentication system's will help you determine how to bypass it. Below is a process to follow.

### Process

#### 1. Understand the typical flow

A typical two-factor authentication scheme looks like the following:

1. Client attempts to access server.
2. Server redirects client to login form.
3. Client enters in username and password (first authentication factor).
4. Server verifies the username and password. If they don't check out, the server denies the client access. If they do, the server issues the client a **temporary cookie** that grants them access to submit the authentication token (second authentication factor). An authentication token is generated on the device or is sent to the target device. The server prompts the client for the authentication token.
	- Is the authentication token generated or sent?
		- Are authentication tokens being constantly generated on the device, or are they generated by a specific event and then sent to the device? If it's the latter, ensure you understand exactly what event triggers the sending of an authentication token. It **should** be the successful verification of the first authentication factor, but it isn't in all implementations.
	- This **temporary cookie** should do two things:
		- Only grant the client access to submit the second authentication factor and not allow any functionality on the application.
		- Only allow the client to submit a second authentication factor for the user corresponding to the verified first authentication factor.
		- Expire quickly (i.e., in a minute or two). If it doesn't, the code could potentially be reused elsewhere to bypass the first authentication factor.
		- Only be good for a few (i.e., three or four) submissions to prevent a brute force attack against the second authentication factor functionality.
5. The client retrieves the authentication token from their device and submits it to the web application.
6. The server verifies the authentication token and grants the client a longer-lasting cookie.
7. The client uses the cookie to interact with the application.

#### 2. Do you even need the second factor?

During step #4 of the typical two-factor authentication flow, what if the server actually granted a full authorization cookie to the client instead of a temporary one that only allowed them enough access to submit the second authentication factor?

It doesn't make any sense, but this is possibility with some applications and is worth trying. Simply login with the first authentication factor, take the cookie that is offered, and when prompted for the second authentication factor, browse to a different, authenticated-users-only URI. You just may be able to access it.

See [PortSwigger Web Security Academy Authentication Lab - 2FA simple bypass](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/authentication/multi-factor-authentication/07%20-%202FA%20simple%20bypass.md).

#### 3. What does the cookie look like?

During step #4 of the typical two-factor authentication flow, what if the server granted the client an temporary cookie that contained within it the user account that, if the second authentication token checked out, the server was to grant the client access to? This isn't that big of a deal if the server is using a [[web-applications/concepts/authorization/jwt|JWT]] (and implements it properly), but what if the server is using a static cookie that can be undetectably modified by the client? What's to stop the client from changing the cookie to access any account they want?

Even worse, if the temporary cookie never expires, an attacker can effectively bypass the first authentication factor for **any user account** on the web application.

See [PortSwigger Web Security Academy Authentication Lab - 2FA broken logic](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/authentication/mutli-factor-authentication/08%20-%202FA%20broken%20logic.md) for an example.

#### 4. Is there any kind of brute-force protection mechanism?

Let's say you obtain a valid username and password and are trying to bypass 2FA to access the user's account. What's stopping you from brute-forcing the user's 2FA code? If the temporary cookie given in step #4 above doesn't expire or it doesn't restrict your number of attempts, determine the number of digits in the code and try it.

If the temporary cookie does expire or restrict your number of attempts, perhaps you can automate the process of logging in with the first authentication factor to get a new temporary cookie, issue a few 2FA codes, and then repeat until you succeed? See [PortSwigger Web Security Academy Authentication Lab - 2FA bypass using a brute force attack](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/authentication/mutli-factor-authentication/09%20-%202FA%20bypass%20using%20a%20brute-force%20attack.md) for an example.