# [dsquery](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc732952(v=ws.11))

> A signed Windows binary for querying an LDAP server. Available for download [here](https://www.microsoft.com/en-us/download/details.aspx?id=45520).

---

## Path

`dsquery.exe` is present by default on Windows machines with the Windows Remote Server Administration Tools (RSAT) package installed at the path `C:\Windows\System32\dsquery.exe`.

---

## General Query Structure

```cmd
dsquery.exe $OBJECT_TYPE [-filter $FILTER] [$OPTIONS]
```

- `$OBJECT_TYPE` has the following options:
	-   `Computer`
	-   `Contact`
	-   `Group`
	-   `OU`
	-   `Site`
	-   `Server`
	-   `User`
	-   `Quota`
	-   `Partition`
	-   `* (Wildcard)`
-   `$FILTER` is the optional LDAP filter
-   Useful `$OPTIONS`:
	-   `-attr $ATTRIBUTES`
		-   Can be a wildcard `*`
		-   Each attribute is separated by a space
	-   `-limit $LIMIT_NUMBER_OF_PRINCPALS`

---

## Extract Users from an Active Directory Domain

```cmd
dsquery.exe user [-attr name samaccountname description]
```

---

## Extract Computers from an Active Directory Domain

```cmd
dsquery.exe computer [-attr name samaccountname]
```

---

## Extract Groups from an Active Directory Domain

```cmd
dsquery.exe group [-attr name samaccountname]
```
