# [/etc/shadow](https://www.cyberciti.biz/faq/understanding-etcshadow-file/)

> `/etc/shadow` is a Unix file that contains user account credential information.

---

## Structure

Each line corresponds to a different user. Within each line, each piece of user account data is delimited by a `:` with the following structure:

```txt
$USERNAME:$PASSWORD_HASH:$LAST_PASSWORD_CHANGE_TIME:$MINIMUM:$MAXIMUM:$WARN:$INACTIVE:EXPIRE
```

From [cyberciti.biz](https://www.cyberciti.biz/faq/understanding-etcshadow-file/):

- `$PASSWORD_HASH`
	- Format is `$ALG_ID$SALT$HASH`
		- `ALG_ID` can be:
    		- `$1$` is MD5
    		- `$2a$` is Blowfish
    		- `$2y$` is Blowfish
    		- `$5$` is SHA-256
    		- `$6$` is SHA-512
- `$LAST_PASSWORD_CHANGE_TIME`
	- Days since Jan 1, 1970 that password was last changed
- `$MINIMUM`
	-  The minimum number of days required between password changes i.e. the number of days left before the user is allowed to change his/her password
-  `$MAXIMUM`
	-  The maximum number of days the password is valid (after that user is forced to change his/her password)
-  `$WARN`
	-  The number of days before password is to expire that user is warned that his/her password must be changed
-  `$INACTIVE`
	-  The number of days after password expires that account is disabled
-  `$EXPIRE`
	-  Days since Jan 1, 1970 that account is disabled i.e. an absolute date specifying when the login may no longer be used.

---

## Cracking the Hashes

Use a different `hashcat` mode depending on the type of hash:

- `$1$`: ([[hashcat#Crack MD5 Unix Hashes|Crack with hashcat]])
- `$2a$`: ([[hashcat#Crack Blowfish Unix Hashes|Crack with hashcat]])
- `$2y$`: ([[hashcat#Crack Blowfish Unix Hashes|Crack with hashcat]])
- `$5$`: ([[hashcat#Crack sha256crypt Hashes|Crack with hashcat]])
- `$6$`: ([[hashcat#Crack sha512crypt Hashes|Crack with hashcat]])