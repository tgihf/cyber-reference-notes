# Insecure Direct Object Reference

An Insecure direct object reference (IDOR) is a type of [[authorization|authorization / access control]] vulnerability in which an application uses user-supplied input to access objects (resources) directly, without applying proper access controls to them first.

For example, say an application identifies users by a numeric identifier (i.e., `0`) and allows users to retrieve their sensitive account information at the URL path `/users/$ID`. You are logged in to a low-privileged account and your identifier is `1096`. You manually navigate to `/users/0` and the application returns the sensitive account information of an `administrator` account.

---

## References

[PortSwigger Web Security Academy](https://portswigger.net/web-security/access-control/idor)
