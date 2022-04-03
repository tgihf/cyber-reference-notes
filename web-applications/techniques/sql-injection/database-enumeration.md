# [SQL Injection Database Enumeration](https://portswigger.net/web-security/sql-injection/examining-the-database)

> When exploiting SQL injection vulnerabilities, it is often necessary to gather some information about the target database itself. This includes the **type and version of the database software** (MySQL 8.0, PostgreSQL 12.3, Oracle 12c, MSSQL 15.0, etc.), and the contents of the database in terms of **which tables it contains** and **which columns its tables contain**.

## Querying the database type and version

Different SQL database versions have different syntax for querying their type and version. The following table summarizes this syntax for each of the four major SQL databases.

| Database Type | Query |
| --- | --- |
| MySQL | [[mysql#Version Query Syntax]] |
| MSSQL | [[mssql#Version Query Syntax]] |
| Oracle | [[oracle#Version Query Syntax]] |
| PostgreSQL | [[postgresql#Version Query Syntax]] |

Since these are `SELECT` statements, you can use them in a [[union-attack]]. If the web application returns output from the table then you'll be able to see the exact type and version number if the injection is successful. If you are attempting to execute a blind SQL injection attack, you can try each one and note which doesn't seem to produce an error, indicating the database type but leaving you ignorant of the version number. That's acceptable though, as the database type is more important in directing the rest of the attack.

---

## Querying database tables and tables' columns

Most databases (with the notable exception of [[oracle]]) have a schema database named `information_schema`. Within this database are tables that contain information on all tables and all of the tables' columns, `information_schema.tables` and `information_schema.columns`, respectively. Oracle contains two database tables that contain this same information: `all_tables` and `all_tab_columns`, respectively.

### Querying database tables (non-Oracle)

```sql
SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE FROM information_schema.tables
```

* Most useful column: `TABLE_NAME` (string column)

### Querying database tables' columns (non-Oracle)

```sql
SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE FROM information_schema.columns where TABLE_NAME = '$TABLE_NAME'
```

* Most useful columns: `COLUMN_NAME` and `DATA_TYPE` (both string columns)

### Querying database tables (Oracle)

```sql
SELECT * FROM all_tables
```

* Most useful column: `TABLE_NAME` (string column)
* [`all_tables` Columns](https://docs.oracle.com/cd/B19306_01/server.102/b14237/statviews_2105.htm#REFRN20286)

### Querying database tables' columns (Oracle)

```sql
SELECT * FROM all_tab_columns WHERE table_name = '$TABLE_NAME'
```

* Most useful columns: `COLUMN_NAME` and `DATA_TYPE` (both string columns)
* [`all_tab_columns` Columns](https://docs.oracle.com/cd/B19306_01/server.102/b14237/statviews_2094.htm)