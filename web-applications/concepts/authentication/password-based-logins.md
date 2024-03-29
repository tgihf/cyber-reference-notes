# [Exploiting Authentication in Password-based Web Applications](https://portswigger.net/web-security/authentication/password-based)

In a web application that leverages password-based authentication, users register for an account themselves or are assigned an account by an administrator. Unique user IDs or usernames are associated with secret passwords. During the authentication process, the user makes an identity claim (the username) and attempts to prove that claim via knowledge of the secret password. If a user is able to submit the correct username and secret password pair, it is considered sufficient to authenticate them.

The critical component of this kind of system is the confidentiality of users' secret password. If a user's secret password is **disclosed**, **easily guessed**, or **brute-forced**, the web application's authentication can be broken.

---

## [[web-applications/techniques/brute-forcing|Brute Forcing]]