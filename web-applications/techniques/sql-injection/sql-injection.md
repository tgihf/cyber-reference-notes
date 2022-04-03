# [SQL Injection](https://portswigger.net/web-security/sql-injection)

> A web application security vulnerability in which a web application doesn't properly sanitize user input before using it in a SQL query that it issues to its backend database, allowing an attacker to interact with the backend database directly. A SQL injection attack can allow an attacker to compromise the confidentiality of the web application by viewing unauthorized information. A SQL injection attack can allow an attacker to compromise the integrity of the web application by modifying or deleting unauthorized web application data. A SQL injection attack can allow an attacker to compromise availability by deleting web application data or performing a denial-of-service attack. A SQL injection attack can even result in an attacker having remote access to the target system.

## Description

Consider a cloud file storage solution that uses a web application as its primary interface. When you login to the web application, your browser requests the following URL.

```http
https://cloud-secure.com?id=8374009
```

The `id` query parameter is used by the web application to uniquely identify you and allow you to access to only files you are authorized to access. The files are stored in a cloud-native SQL database and the web application retrieves the files you are authorized to access via the following SQL query.

```sql
SELECT * from files where id = '8374009';
```

The web application's back end code that generates this SQL query and issues it to the database looks like this.

```python
sql_query = f"SELECT * from files where id = '{id}'"
rows = db.execute(sql_query)
```

Since the web application inserts `id` directly into the SQL query without any kind of sanitization and since `id` is merely an HTTP query parameter controllable by the user, an attacker can send a specially crafted `id` to break out of the intended SQL query and interact directly with the backend database, for example:

```http
https://cloud-secure.com?id=8374009'+OR+1=1;--
```

Resulting in the following SQL query being sent to the backend database:

```sql
SELECT * from files where id = '8374009' OR 1=1;--'
```

This SQL query retrieves all columns from the `files` table where `id` is 8374009 or when 1 is equal to 1. Since 1 is always equal to 1, all columns from the `files` table are returned. This returns to the attacker all of the cloud file storage solution's files, including those that don't belong to the attacker.

---

## Understanding the SQL query you're injecting into

The key to exploiting any SQL injection vulnerability is fully understanding the SQL query that you're injecting into. Play around with the web application to attain a thorough understanding of the underlying SQL query. Once you think you understand it, attempt to write it out with a `$VARIABLE` in the injection point. With the query written out, first paste all of your injection attempts into the query and see if the syntax is doing what you think it should. You could even test it against a test database ([[mysql#Interact with test database]], [[postgresql#Interact with test database]]). Once you are confident in your syntax, **then** attempt the injection on the target.

---

## Process

1. Identify SQL injection vulnerability
	* This will likely result in an error from the web application
2. Identify comment syntax
	* This will likely fix the error from the web application by commenting out the syntactically incorrect remainder of the query
	* Comment syntax for various popular databases:
		* [[mssql#Comment Syntax]]
		* [[mysql#Comment Syntax]]
		* [[oracle#Comment Syntax]]
		* [[postgresql#Comment Syntax]]
3. Follow process based on objectives
	* Authentication bypass?
		* [[authentication-bypass]]
	* Information disclosure?
		* Are the rows retrieved from the SQL query rendered on the web page?
			* Yes: [[union-attack]]
			* No: are SQL error messages rendered on the web page?
				* Yes: [[error-based-sql-injection]]
				* No: [[blind-sql-injection]]
	* Database modification?
	* Database deletion?
	* Remote access?