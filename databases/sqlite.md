# [SQLite](https://en.wikipedia.org/wiki/SQLite)

> A relational database management system(RDBMS) contained in a C library. In contrast to many other database management systems, SQLite is not a client–server database engine. Rather, it is embedded into the end program. Often stores the database in a file.

## Comment Syntax

1. `--` denotes a single-line comment
	* `--COMMENT HERE`
	* No required whitespace, unlike MySQL
2. `/* */` denotes a multi-line comment
	* `/*COMMENT HERE*/` 

---

## Version Query Syntax

```sql
SELECT sqlite_version()
```

---

## String Concatenation Syntax

```sql
SELECT username||':'||password FROM users
```

* Can concatenate both column names and string literals in any order

---

## Cast an Integer into a Character

```sql
-- CAST($INTEGER as text)
```

```sql
SELECT path FROM paths WHERE path = CONCAT(CAST(47 as text),'var',CAST(47 as text),'www',CAST(47 as text),'html',CAST(47 as text),'shell',CAST(46 as text),'php') -- /var/www/html/shell.php
```

* Especially helpful for bypassing tricky input restrictions on file paths (i.e., no `/`, `\`, and `.` allowed)

---

## Substring Syntax

```sql
SUBSTR($STRING, $START_INDEX, $LENGTH)
```

```sql
SELECT COUNT(*) FROM users WHERE SUBSTR(password,1,1) > 'm'
```
* Indices start at 1

---

## Conditional Syntax

```sql
SELECT CASE WHEN ($CONDITION) THEN $VALUE_IF_TRUE ELSE $VALUE_IF_FALSE END
```

```sql
SELECT CASE WHEN (COUNT(*) = 1) THEN 1 ELSE 0 END FROM users WHERE username = 'admin' and password = 'password123' -- returns 1 if password equals 'password123', 0 otherwise
```

---

## Time Delay Syntax

[Reference](https://www.sqlitetutorial.net/sqlite-case/)

### Unconditionally wait 10 seconds

```sql
SELECT sqlite3_sleep(10000)
```

### Conditionally wait 10 seconds

```sql
SELECT CASE WHEN ($CONDITION) THEN sqlite3_sleep(10000) ELSE pg_sleep(0) END
```

---

## Table enumeration

```sql
SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE 'sqlite_%'
```
* Useful columns: `NAME`
* [`sqlite_master` Columns](https://www.sqlite.org/schematab.html)

---

## Table Column Enumeration

```sql
SELECT sql FROM sqlite_master WHERE type = 'table' AND name = '$TABLE_NAME'
```
* `sql` column stores the SQL string that describes the object. In this instance, it stores the `CREATE TABLE` statement that created `$TABLE_NAME`. This will give you the columns and their types.
* [`sqlite_master` Columns](https://www.sqlite.org/schematab.html)

---

## Interact with a SQLite Database File from the Command Line

```bash
sqlite3 $DATABASE_FILE
```
