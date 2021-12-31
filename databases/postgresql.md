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

---

## Show Databases in `psql`

```txt
postgres=# \l+
```

Also:

```sql
SELECT datname FROM pg_database;
```

---

## Connect to Database in `psql`

```txt
postgres=# \c $DATABASEN_NAME
```

---

## Show Tables in Database in `psql`

```txt
postgres=# \dt+
```

---

## Command Execution in PostgreSQL

If you can execute arbitrary SQL statements on a PostgreSQL server, you can most likely execute operating system commands as well.

On Linux and in PostgreSQL < 8.2, you can import the `system` function from `/lib/x86_64-linux-gnu/libc.so.6` and run arbitrary operating system commands as the user running PostgreSQL. There is even a [Metasploit module](https://www.rapid7.com/db/modules/exploit/linux/postgres/postgres_payload/) for this.

On Linux and in PostgreSQL >= 8.2, PostgreSQL started requiring a "magic block" of data at the beginning of the shared object file for it to be imported that `libc` doesn't have. You can trivially write your PostgreSQL extension that runs `system` and compile it into a compliant shared object file. See `NIX01` in `HTB Offshore` for an example.

Details on how to execute both of these attacks, and command execution attacks on Windows, can be found on [HackTricks](https://book.hacktricks.xyz/pentesting-web/sql-injection/postgresql-injection/rce-with-postgresql-extensions). [This repository](https://github.com/Dionach/pgexec) also contains pre-compiled shared object files and the ability to automate the exploitation.
