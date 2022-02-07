# Interacting with the Registry via `cmd`

---

## Retrieve Registry Key

```cmd
reg query $PATH_TO_SUBKEY
```

Example path: `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`

---

## Retrieve Registry Key Entry

```powershell
reg query $PATH_TO_SUBKEY /v $ENTRY_NAME
```

Example path: `HKLM:\Software\Microsoft\Windows\CurrentVersion\Run`

---

## Add Registry Key

```powershell
reg add $PATH_TO_SUBKEY
```

Example path: `HKLM:\Software\Microsoft\Windows\CurrentVersion\Run`

---

## Add Registry Key Entry

```powershell
reg add $PATH_TO_SUBKEY /v $ENTRY_NAME /t $ENTRY_TYPE /d $ENTRY_VALUE
```

Example path: `HKLM:\Software\Microsoft\Windows\CurrentVersion\Run`

Possible values for `$ENTRY_TYPE`:

-   **REG_SZ**: Specifies a null-terminated string
-   **REG_EXPAND_SZ**: Specifies a null-terminated string that contains unexpanded references to environment variables that are expanded when the value is retrieved
-   **REG_BINARY**: Specifies binary data in any form
-   **REG_DWORD**: Specifies a 32-bit binary number
-   **REG_MULTI_SZ**: Specifies an array of null-terminated strings terminated by two null characters
-   **REG_QWORD**: Specifies a 64-bit binary number

---

## Delete Registry Key

```powershell
reg delete $PATH_TO_SUBKEY
```

Example path: `HKLM:\Software\Microsoft\Windows\CurrentVersion\Run`

---

## Delete Registry Key Entry

```powershell
reg delete $PATH_TO_SUBKEY /v $ENTRY_NAME
```

Example path: `HKLM:\Software\Microsoft\Windows\CurrentVersion\Run`

---

## Update a Service's Registry Key's Binary Path

```batch
reg add HKLM\SYSTEM\CurrentControlSet\services\$SERVICE_NAME /v ImagePath /t REG_EXPAND_SZ /d $PATH_TO_SERVICE_BINARY /f
```
