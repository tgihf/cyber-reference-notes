# powercat

> [[netcat|Netcat]]: the PowerShell version.

---

## Import from URL

`powercat` is a function defined with the `powercat.ps1` module. You need to import that module to get access to the function.

```powershell
IEX (New-Obejct System.Web.NetClient).downloadString("$URL")
```

---

## Connect to remote port

```powershell
powercat -c $REMOTE_IP -p $REMOTE_PORT
```

---

## Listen for a connection on all interfaces

```powershell
powercat -l -p $LISTEN_PORT
```

---

## File Transfer

```powershell
powercat -c $REMOTE_IP -p $REMOTE_PORT -i $FILE_PATH
```

---

## File Reception

```powershell
powercat -l -p $LISTEN_PORT -of $OUTPUT_PATH
```
