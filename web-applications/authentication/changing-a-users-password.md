# Changing a User's Password

## Overview

Changing your password typically involves being authenticated, navigating to a password change form, entering your current password and your new password twice, and submitting the form. This functionality often performs the same username and password lookup that the login process does and may be similarly vulnerable.

---

## Exploiting the Change Password Functionality

### Can you submit a change password request unauthenticated?

 If so, you may be able to both enumerate usernames and brute-force passwords, just like typical [[password-based-logins|password-based logins]].

### Can you submit a change password request authenticated but for another user?

If so, you may be able to both enumerate usernames and brute-force passwords, just like typical [[password-based-logins|password-based logins]].

### What happens when new passwords don't match?

Try all different "truth table" input combinations to map the backend's response and try to understand and reverse engineer its behavior. For an example of this, see [PortSwigger Web Security Academy Lab - Password brute-force via password change](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/authentication/vulnerabilities-in-other-authentication-mechanisms/14%20-%20Password%20brute-force%20via%20password%20change.md).
