# Microsoft SQL

## Comment syntax

1. `--` denotes a single-line comment
	* `--COMMENT HERE`
	* No required whitespace, unlike MySQL
2. `/* */` denotes a multi-line comment
	* `/*COMMENT HERE*/` 

---

## Version query syntax

```sql
SELECT @@version
```

---

## String concatenation syntax

```sql
SELECT CONCAT(username, ':', password) FROM users
```

* Takes a variable number of arguments
* Arguments can be column names from the target table or string literals

---

## Time delay syntax

[Reference](https://portswigger.net/web-security/sql-injection/cheat-sheet)

### Unconditionally wait for 10 seconds

```sql
WAITFOR DELAY '0:0:10'
```

### Conditionally wait for 10 seconds

```sql
IF ($CONDITION) WAITFOR DELAY '0:0:10'
```

---

## Table enumeration

[[database-enumeration#Querying database tables non-Oracle]]

---

## Table column enumeration

[[database-enumeration#Querying database tables' columns non-Oracle]]

---

## MSSQL Client

[[mssqlclient|impacket-mssqlclient]]
