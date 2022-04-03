# [Blind SQL Injection](https://portswigger.net/web-security/sql-injection/blind)

> Blind SQL injection arises when an application is vulnerable to SQL injection, but its HTTP responses do not contain **the results of the relevant SQL query** or **the details of any database errors**.

With blind SQL injection vulnerabilities, many techniques such as [`UNION` attacks](union-attack.md) are not effective because they rely on being able to see the results of the injected query within the application's responses. However, it is still possible to exploit blind SQL injection to achieve various goals, but different techniques must be used.

## Process

### 1. Understand the SQL query you're injecting into

[[sql-injection#Understanding the SQL query you're injecting into]]

### 2. Identify feedback from the web application

In blind SQL injection, you don't have the luxury of having the SQL output rendered on the web page. Instead, the focus is on **asking the database questions** and **leveraging application-specific feedback to understand its answers**.

What does this feedback look like? It's contextual.

The key is this: figure out if the application offers binary feedback based on the outcome of the injected SQL query's execution: if the query is "successful," it does one thing and if it's not "successful," it does another. This behavior can be leveraged to ask the database questions and interpret its answers.

Below are some different examples of feedback and how you can leverage them to exploit a blind SQL injection vulnerability:
* [[blind-sql-injection#Boolean-based SQL Injection]]:  Use when the application's behavior depends upon whether or not the query returns any rows from the database. Use an `AND SELECT` operation to force the return of some or zero rows if a condition is true.
* [[blind-sql-injection#Error-based Blind SQL Injection]]: Use when the application's behavior **does not** depend upon whether the query returns any rows from the database, but instead changes based on whether the query throws an error. Use an `AND SELECT CASE WHEN THEN ELSE` operation to force the throwing of a particular SQL error (i.e., divide-by-zero) if a condition is true.
* [[blind-sql-injection#Time-based Blind SQL Injection]]: Use when the application's behavior doesn't depend on whether any rows are returned from the query or on whether the query throws an error (AKA, the application pretty much gives you nothing), but you think the query is still executed synchronously before the response is returned. Use a database platform-dependent time delay to determine if a condition is true.
* [[blind-sql-injection#Out-of-Band Blind SQL Injection]]: Use when the application's behavior doesn't depend on whether any rows are returned from the query or on whether the query throws an error and the query is executed asynchronously. `REQUIRES THE EXECUTION OF STACKED QUERIES.`

---

## Specific Feedback Examples

### Boolean-based SQL Injection

> Manipulate the conditions in the original query to interpret conditional responses

[Reference](https://portswigger.net/web-security/sql-injection/blind)

A web application might display certain HTML elements like "Welcome back!" whenever the SQL query returns at least one row, and not display those elements when the SQL query returns no rows. In this context, you could use a logical `AND` operation with another `SELECT` query, brute-forcing for each letter in a user's password. Whenever the letter guess is correct, the logical `AND` forces the return of at least one row and causes the "Welcome back!" banner element to appear. Whenver the letter guess is incorrect, the logical `AND` forces the return of no rows and causes the "Welcome back!" banner element to disappear.

For example, the vulnerable SQL query:

```sql
SELECT TrackingId FROM TrackingIds WHERE TrackingId = '$TRACKING_ID'
```

and the injection:

```txt
YXLeVeN8Qh1b6wlg' AND (SELECT SUBSTRING(password, $INDEX, 1) FROM users WHERE username = 'administrator') = '$CHARACTER'--
```

giving us:

```sql
SELECT TrackingId FROM TrackingIds WHERE TrackingId = 'YXLeVeN8Qh1b6wlg' AND (SELECT SUBSTRING(password, $INDEX, 1) FROM users WHERE username = 'administrator') = '$CHARACTER'--'
```

### Error-based Blind SQL Injection

> Trigger SQL errors to interpret conditional responses

[Reference](https://portswigger.net/web-security/sql-injection/blind)

A web application may not render any differently based on how many rows the SQL query returns, but instead render an error page whenever a SQL error is thrown. In this context, you could leverage another logical `AND` operation with another `SELECT` query, this time with a `CASE WHEN THEN ELSE END` statement that forces the throwing of an divide-by-0 error whenever a condition is met. In this structure, you could also brute-force each letter in a user's password and whenever a letter guess is correct, trigger the divide-by-0 error, causing the web application to render an error page.

For example, the vulnerable SQL query:

```sql
SELECT TrackingId FROM TrackingIds WHERE TrackingId = '$TRACKING_ID'
```

and the injection:

```txt
mvdV0sPOiMwwSEVe' AND (SELECT CASE WHEN (SUBSTR(password, $INDEX, 1) = '$CHARACTER') THEN TO_CHAR(1/0) ELSE 'a' END FROM users WHERE username = 'administrator') = 'a'--'
```

giving us:

```sql
SELECT TrackingId FROM TrackingIds WHERE TrackingId = 'mvdV0sPOiMwwSEVe' AND (SELECT CASE WHEN (SUBSTR(password, $INDEX, 1) = '$CHARACTER') THEN TO_CHAR(1/0) ELSE 'a' END FROM users WHERE username = 'administrator') = 'a'--''
```

### Time-based Blind SQL Injection

> Trigger time delays to interpret conditional responses

[Reference](https://portswigger.net/web-security/sql-injection/blind)

A web application may not change its behavior based on whether the query returns any rows or whether the query throws any errors. In this case, the web application pretty much gives you *no* indication on the results of the query.

However, if you believe the SQL query is executed synchronously (that is, the web application waits for it to finish before returning a response), then you can force the database to indicate the results of the query using a **time delay**.

A time delay command makes the database wait for an arbitrary amount of time before proceeding. Using `SELECT CASE WHEN THEN ELSE END`, you can conditionally trigger a time delay, allowing you to ask the database questions and interpret its answers.

Time delay command syntax for various database platforms:

| Database | Time Delay Command |
| --- | --- |
| MSSQL | [[mssql#Time delay syntax]] |
| MySQL | [[mysql#Time delay syntax]] |
| Oracle | [[oracle#Time delay syntax]] |
| PostgreSQL | [[postgresql#Time delay syntax]] |

For example, you could brute force a each character in a user's password and each time a guess is correct, the database will pause for 5 seconds. Each time a guess is incorrect, the database won't pause at all. The vulnerable SQL query:

```sql
SELECT first_name FROM employees WHERE first_name = '$FIRST_NAME' LIMIT 1;
```

and the injection:

```txt
Sachin' AND (SELECT CASE WHEN (1=1) THEN sleep(5) ELSE 1 END FROM employees WHERE first_name = 'Sachin' LIMIT 1) = 0 LIMIT 1;--
```

giving us:

```sql
SELECT first_name FROM employees WHERE first_name = 'Sachin' AND (SELECT CASE WHEN (SUBSTRING(password, 1, 1) = 'a') THEN sleep(5) ELSE 1 END FROM employees WHERE first_name = 'Sachin' LIMIT 1) = 0 LIMIT 1;--' LIMIT 1;
```

### Out-of-Band Blind SQL Injection

> Trigger out-of-band requests (i.e., DNS, HTTP) to interpret conditional responses or exfiltrate data

[Reference](https://portswigger.net/web-security/sql-injection/blind)

A web application may not change its behavior based on whether the query returns any rows or whether the query throws any errors. Additionally, the web application may process the injected input asynchronously (that is, the web application begins processing the injected input but does *not* wait for it to complete before returning a response to the user). In this case, the web application pretty much gives you *no* indication on the results of the query.

However, it may be possible to trigger out-of-band network interactions on the target database to a host that you control. For example, MSSQL's `xp_dirtree` command can be used to trigger DNS requests and Oracle's `UTL_HTTP` package can be used to trigger HTTP requests. You could ask the database a question (i.e., "is the first letter of the password greater than 'm'?") and then have it make an HTTP request if the answer is yes. Alternatively, you could exfiltrate data via a DNS request by making the data string the subdomain of a domain that you control.



---

## Writeups

Writeups of you performing blind SQL injection attacks can be found in your PortSwigger Web Academy Blind SQL Injection writeups.
