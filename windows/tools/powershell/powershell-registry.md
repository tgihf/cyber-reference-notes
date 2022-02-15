# Interacting with the Registry via PowerShell

---

## Retrieve Registry Key

```powershell
Get-Item -Path $ROOT_KEY:$PATH_TO_SUBKEY
```

Example path: `HKLM:\Software\Microsoft\Windows\CurrentVersion\Run`

---

## Retrieve Registry Key Entry

```powershell
Get-ItemProperty -Path $ROOT_KEY:$PATH_TO_SUBKEY -Name $ENTRY_NAME
```

Example path: `HKLM:\Software\Microsoft\Windows\CurrentVersion\Run`

---

## Add Registry Key

```powershell
New-Item -Path $ROOT_KEY:$PATH_TO_SUBKEY -Name $ENTRY_NAME
```

Example path: `HKLM:\Software\Microsoft\Windows\CurrentVersion\Run`

---

## Add Registry Key Entry

```powershell
New-ItemProperty -Path $ROOT_KEY:$PATH_TO_SUBKEY -Name $ENTRY_NAME -PropertyType $ENTRY_TYPE -Value $ENTRY_VALUE
```

Example path: `HKLM:\Software\Microsoft\Windows\CurrentVersion\Run`

Possible values for `$ENTRY_TYPE`:

-   **String**: Specifies a null-terminated string. Equivalent to **REG_SZ**.
-   **ExpandString**: Specifies a null-terminated string that contains unexpanded references to environment variables that are expanded when the value is retrieved. Equivalent to **REG_EXPAND_SZ**.
-   **Binary**: Specifies binary data in any form. Equivalent to **REG_BINARY**.
-   **DWord**: Specifies a 32-bit binary number. Equivalent to **REG_DWORD**.
-   **MultiString**: Specifies an array of null-terminated strings terminated by two null characters. Equivalent to **REG_MULTI_SZ**.
-   **Qword**: Specifies a 64-bit binary number. Equivalent to **REG_QWORD**.
-   **Unknown**: Indicates an unsupported registry data type, such as **REG_RESOURCE_LIST**.

---

## Delete Registry Key

```powershell
Remove-Item -Path $ROOT_KEY:$PATH_TO_SUBKEY
```

Example path: `HKLM:\Software\Microsoft\Windows\CurrentVersion\Run`

---

## Delete Registry Key Entry

```powershell
Remove-ItemProperty -Path $ROOT_KEY:$PATH_TO_SUBKEY -Name $ENTRY_NAME
```

Example path: `HKLM:\Software\Microsoft\Windows\CurrentVersion\Run`

---

## Update a Service's Registry Key's Binary Path

```powershell
New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\services\$SERVICE_NAME -Name ImagePath -PropertyType ExpandString -Value $PATH_TO_SERVICE_BINARY
```
