## Three Types of Authorization Schemes

1. Host-based access
2. [[x11-authorization#Cookie-based Access|Cookie-based access]]
3. User-based access

---

## Cookie-based Access

Cookie-based authorization involves the generation of an arbitrary secret cookie and X11 clients presenting this cookie to the X11 server for authorization purposes.

By default, X11 clients expect the secret cookie to be stored in the `.Xauthority` file in the user's home directory. If this file doesn't exist, the X11 client will attempt to read the secret cookie from the file at the path in the `XAUTHORITY` environment variable.

---

## References

[X Window Authorization - Wikipedia](https://en.wikipedia.org/wiki/X_Window_authorization)
