# SQL Injection Authentication Bypass

> If a web application passes unsanitized, user-input credentials to a backend database for authentication purposes, SQL injection may make it possible to bypass authentication altogher.

## Example Server-Side Code

```python
# Extract credentials from form
username = request.form["username"]
password = request.form["password"]

# Construct and execute the SQL query
sql_query = f"SELECT * from users where username = '{username}' AND password = '{password}'"
rows = db.execute(sql_query)

# Failed login
if len(rows) == 0:
	redirect("Login", flash="Sorry, those credentials were incorrect!")
	
# Successful login
else:
	user = rows[0]
	redirect("Dashboard", user=user, flash=f"Welcome, {user.name}!")
```

This code inserts the user-input username and password directly into a SQL query, executes the query, and then allows or restricts the user access to the web application based on whether or not the query returned any rows from the `users` table.

---

## Exploitation

An attacker's target is to gain access to the `admin` account. If the attacker was to send a login request with the username `admin'--` and password `ANYTHING`, it would result in the following SQL query being sent to the database:

```sql
SELECT * from users where username = 'admin'--' AND password = 'ANYTHING'
```

This query returns the row with username = `admin` and since it returned at least one row, logs the user in as `admin`.

Though the attacker didn't know `admin`'s password, they were able to leverage a SQL injection vulnerability to bypass authentication and login as `admin`.