# Windows Services

> Windows services run executables on a schedule or when triggered by an event. Services can run in the security context of any user, including `SYSTEM`.

---

## Service Properties

### Binary Path

The path of the service's executable. Windows service binaries are often in `C:\Windows\System32` and `C:\Windows\SysWOW64`. Third party service binaries are often in `C:\Program Files` and `C:\Program Files (x86)`.

### Startup Type

Determines when the service should start.

-   `Automatic` - The service starts immediately on boot
-   `Automatic (Delayed Start)` - The service waits a short amount of time after boot before starting (mostly a legacy option to help the desktop load faster)
-   `Manual` - The service will only start when specifically asked
-   `Disabled` - The service is disabled and won't run

### Status

Current status of the service.

-   `Running` - The service is running
-   `Stopped` - The service is not running
-   `StartPending` - The service has been asked to start and is executing its startup procedure
-   `StopPending` - The service has been asked to stop and is executing its shutdown procedure

### Log On As

The user account that the service is configured to run as.

### Dependents & Dependencies

Other services the current service is dependent to run on, and other services that depend on the current service to run. These help you understand the potential impact of manipulation.

---

## Query Services

- [[sc#Query Services]]
- [[wmic#Query Services]]
- [[powershell-services|powershell > Query Services]]

---

## Exploiting Service Misconfigurations

See [[service-misconfigurations|here]].