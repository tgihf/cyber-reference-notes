# netsh

> Command line utility for displaying or modifying a machine's network configuration.

---

## Configure Firewall to Allow Traffic to Local Port

```batch
netsh advfirewall firewall add rule name="$RULE_NAME" dir=in action=allow protocol=$PROTOCOL localport=$PORT_NUMBER
```

- `$PROTOCOL` can be `TCP` or `UDP`

---

## Remove Firewall Rule

```batch
netsh advfirewall firewall delete rule name="$RULE_NAME" protocol=$PROTOCOL localport=$PORT_NUMBER
```

- `$PROTOCOL` can be `TCP` or `UDP`
