# Windows Access Tokens

Whenever a user logs into a system, the system generates an access token that contains the following security information for that logon session: the user's SID, the user's groups, and the user's privileges. Every process executed on behalf of the user holds a copy of this token and uses it to authorize requests.

---

## Local Administrator Access Tokens

When a user that is a local administrator logs into a system, **two** access tokens are generated: one with administrative rights and another with normal rights. By default when the user runs processes they are executed with the normal access token. Whenever the user chooses to run a process "as administrator," UAC will ask for permission and if it is granted, the process will run with the administrative access token.

---

## View Logon Session's Access Token

```cmd
whoami /all
```

---

## See What Your Groups Can Do

Some of the groups within Windows have significant privileges. Look for the groups that you are in in [this article](https://cube0x0.github.io/Pocing-Beyond-DA/) to do determine what you can do.

---

## References

[HackTricks Windows Access Tokens](https://book.hacktricks.xyz/windows/windows-local-privilege-escalation/access-tokens)
