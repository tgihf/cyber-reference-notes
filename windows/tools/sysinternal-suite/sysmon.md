# Sysmon

- Complements native Windows logging via an extended and extendable custom XML configuration file
	- SwiftOnSecurity has published a [configuration file](https://github.com/SwiftOnSecurity/sysmon-config) that covers a lot of bases and is easy to customize for your needs
- On Vista and higher, logs are written to `Applications and Services Logs/Microsoft/Windows/Sysmon/Operational`
- Older than Vista, logs are written to the `System` event log
- Installs as a service and device driver in order to analyze Windows events

---

## Installation

1. Download the Sysmon ZIP archive
	- Contains a EULA and 32- and 64-bit versions of the installer
2. Install

```batch
$PATH_TO_SYSMON_EXE -accepteula [-i $PATH_TO_CONFIGURATION_FILE]
```

---

## Uninstallation

```batch
$PATH_TO_SYSMON_EXE -accepteula -u
```

---

## References

[Sysmon - Microsoft Docs](https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon)

[SwiftOnSecurity's Sysmon Configuration Template](https://github.com/SwiftOnSecurity/sysmon-config/blob/master/sysmonconfig-export.xml)