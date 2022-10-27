# PowerUpSQL

> PowerShell module for [[mssql|Microsoft SQL Server]] discovery, interaction, configuration auditing, privilege escalation, and post exploitation.

---

## Discover MSSQL Servers on Current Domain

This cmdlet works by enumerating the domain controller for principals via LDAP and filtering those principals for ones with [[service-principal-name|SPNs]] that begin with `MSSQL*`.

```powershell
Get-SQLInstanceDomain
```

---

## Determine Whether the Current Context can Interact with an MSSQL Server

```powershell
Get-SQLConnectionTest -Instance "$MSSQL_SERVER_FQDN_OR_IP,$MSSQL_PORT"
```

- `$MSSQL_PORT` is likely `1433`

---

## Gather Information About an MSSQL Server

The current context must [[power-up-sql#Determine Whether the Current Context can Interact with an MSSQL Server|be able to interact with the MSSQL server]].

```powershell
Get-SQLServerInfo -Instance "$MSSQL_SERVER_FQDN_OR_IP,$MSSQL_PORT"
```

---

## Issue SQL Query to MSSQL Server

The current context must [[power-up-sql#Determine Whether the Current Context can Interact with an MSSQL Server|be able to interact with the MSSQL server]].

```powershell
Get-SQLQuery -Instance "$MSSQL_SERVER_FQDN_OR_IP,$MSSQL_PORT" -Query "$SQL_QUERY"
```

---

## Execute Command on MSSQL Server

The current context must [[power-up-sql#Determine Whether the Current Context can Interact with an MSSQL Server|be able to interact with the MSSQL server]].

This command automatically [[mssql#Determine Whether xp_cmdshell is Enabled on an MSSQL Server|determines whether xp_cmdshell is enabled]], [[mssql#Enable xp_cmdshell on an MSSQL Server|enables it if necessary]], and [[mssql#Disable xp_cmdshell on an MSSQL Server|re-disables it if necessary]].

```powershell
Invoke-SQLOSCmd -Instance "$MSSQL_SERVER_FQDN_OR_IP,$MSSQL_PORT" -Query "$SQL_QUERY"
```

---

## Recursively Enumerate an MSSQL Server's Linked Servers

```powershell
Get-SQLServerLinkCrawl -Instance "$MSSQL_SERVER_FQDN_OR_IP,$MSSQL_PORT"
```

---

## References

[PowerUpSQL GitHub Repository](https://github.com/NetSPI/PowerUpSQL)
