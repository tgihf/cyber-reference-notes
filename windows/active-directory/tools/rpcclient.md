# rpcclient

> A Linux tool that is part of the Samba package. Allows a Linux client to execute Microsoft RPC functions.

---

## Authenticate into RPC Shell

```bash
rpcclient -U $USERNAME //$TARGET_FQDN_OR_IP
```

You'll be prompted for `$USERNAME`'s password.

---

## Change a User's Password

The command must be executed in the context of a principal that has `ForceChangePassword` permission to the target principal. This permission allows the subject principal to change the target principal's password **without knowing it**.

```bash
rpcclient $> setuserinfo2 $TARGET_USERNAME 23 $NEW_PASSWORD
```

Use [[crackmapexec]] to verify the password was successfully changed.

---

## References

[Blog Post](https://malicious.link/post/2017/reset-ad-user-password-with-linux/)
