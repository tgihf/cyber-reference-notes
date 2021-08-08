# PostgreSQL

## Comment Syntax

1. `--` denotes a single-line comment
	* `--COMMENT HERE`
	* No required whitespace, unlike MySQL
2. `/* */` denotes a multi-line comment
	* `/*COMMENT HERE*/` 

---

## Version Query Syntax

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

```sql
SELECT username||':'||password FROM users
```

* Can concatenate both column names and string literals in any order

---

## Time delay syntax

[Reference](https://portswigger.net/web-security/sql-injection/cheat-sheet)

### Unconditionally wait 10 seconds

```sql
SELECT pg_sleep(10)
```

### Conditionally wait 10 seconds

```sql
SELECT CASE WHEN ($CONDITION) THEN pg_sleep(10) ELSE pg_sleep(0) END
```

---

## Table enumeration

[[database-enumeration#Querying database tables non-Oracle]]

---

## Table column enumeration

[[database-enumeration#Querying database tables' columns non-Oracle]]

---

## Interact with test database

On a Linux machine with Docker installed, run the PostgreSQL Docker container.
* Change `$PASSWORD`

```bash
docker run --name postgres-test \
	-d \
	-e POSTGRES_PASSWORD=$PASSWORD \
	-p 5432:5432 \
	postgres
```

Connect to the PostgreSQL database.

```bash
psql -h 127.0.0.1 -p 5432 -U postgres -W
```

Create an `employees` test table.

```bash
postgres=# CREATE TABLE employees ( user_id serial PRIMARY KEY, username VARCHAR ( 50 ) UNIQUE NOT NULL, password VARCHAR ( 50 ) NOT NULL, email VARCHAR ( 255 ) UNIQUE NOT NULL, created_on TIMESTAMP NOT NULL, last_login TIMESTAMP );
```

Populate the test table.

```bash
postgres=# INSERT INTO employees (user_id, username, password, email, created_on, last_login) VALUES (0, 'alice', 'alice-password', 'alice@blah.home', '2010-01-08', '2011-02-14');
```

```bash
postgres=# INSERT INTO employees (user_id, username, password, email, created_on, last_login) VALUES (1, 'bob', 'bob-password', 'bob@blah.home', '2016-12-02', '2018-05-26');
```

```bash
postgres=# INSERT INTO employees (user_id, username, password, email, created_on, last_login) VALUES (2, 'charles', 'charles-password', 'charles@blah.home', '2017-01-03', '2019-06-28');
```

Query away!