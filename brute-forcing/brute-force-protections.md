# Brute Force Protections

## [Login Brute Force Protections](https://portswigger.net/web-security/authentication/password-based)

Login brute-force protection revolves around trying to make it as difficult as possible to automate the process and slow down the rate at which an attacker can attempt logins.

### 2 Most Common Login Brute Force Protection Mechanisms

### 1. Account Lockout

This is a serious mechanism that can result in denial of service for users whose accounts are brute forced. The key here is understanding the *implementation* of the account locking by asking the following questions:

- How many failed login attempts result in an account being locked?
	- Once this is determined, you could leverage a small-but-common password list with *just* enough passwords to prevent a lock out.
	- Credential stuffing attacks are also resilient against this, as they use credentials from breaches that often don't repeat usernames very much.
- Exactly how does the application behave differently when attempting to login to a locked account? Is it possible that the response for successfully logging into a locked account is different than the response for attempting to log into a locked account with incorrect credentials? (See PortSwigger Web Academy Challenge #5: "Username enumeration via account lockout" for an example). If this is the case, the brute force mechanism is practically useless, as you can still brute force the login and note the outlier credentials.
- What does it take for an account to be unlocked? A certain amount of time to pass? The intervention of an administrator?
	- Understanding this condition can help you automate the process of getting going again after a lock out has occurred.

Account lockout also encourages [[username-enumeration]]. If you are able to lock out an account with a particular username, you can bet that is a valid account. You can brute force usernames by attempting to lock out each account.

### 2. Block Remote User's IP Address

This is not as a serious a mechanism as #1 as it can be bypassed in several ways, depending on the application's implementation of the IP blocking. The questions to ask are these:

- On how many failed login attempts does the web application block the IP address?
- How does the web application differentiate between different IPs when proxies are in play (as they most often are)?
- On what condition does the web application remove the IP from the blocked list?

A few possible techniques:

#### Proxy Pretending: `X-Forwarded-For` Header

In answer to question #2 above, the web application may first consider the true source of the request to be the IP address specified in the `X-Forwarded-For` header. If this header isn't present, then it considers the true source of the request to be the actual source IP address. If this is the case, you can update the `X-Forwarded-For` header with every request and the application will interpret each as if it came from a different source (see PortSwigger Web Academy Authentication Lab Challenge #3 - "Username enumeration via response timing" for an example). 

#### Proxy Cycling

Cycle through several proxies as you conduct the attack. It's helpful to know the answer to question #1 above as well to determine how many proxies should be cycled through to prevent lockouts. Alternatively, use Lambda Proxy (if you've implemented it yet!).

#### Login Successfully

In answer to question #3 above, some web applications unblocked an IP address after a successful login attempt from it. By interspersing valid login credentials (if you have them) throughout the keyspace/dictionary, you would effectively bypass the IP address blocking. See PortSwigger Web Academy Authentication Lab Challenge #4 - "Broken brute-force protection, IP block" for an example.

