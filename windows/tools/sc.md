# sc

> [[windows/tools/cmd/cmd|cmd]] command for viewing and configuring services configured on a local or remote Windows systems.

---

## Query Services

```cmd
sc [$SERVER_FQDN_OR_IP] queryex type=service state=all
```

---

## Create a Local Service

```cmd
sc create $SERVICE_NAME binpath= "$COMMAND_TO_EXECUTE" start= "auto"
```

---

## Start a Local Service

```cmd
sc start $SERVICE_NAME
```

---

## Stop a Local Service

```cmd
sc stop $SERVICE_NAME
```

---

## Create a Remote Service

```cmd
sc $SERVER_FQDN_OR_IP create $SERVICE_NAME binpath= "$COMMAND_TO_EXECUTE" start= "auto"
```

---

## Start a Remote Service

```cmd
sc $SERVER_FQDN_OR_IP start $SERVICE_NAME
```

---

## Update a Service's Executable Path

```cmd
sc [$SERVER_FQDN_OR_IP] config $SERVICE_NAME binpath= "$COMMAND_TO_EXECUTE"
```

---

## Query for Existence of Windows Defender Service

```cmd
sc query windefend
```
