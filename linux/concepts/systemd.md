# [systemd](https://en.wikipedia.org/wiki/Systemd)

> a Linux initialization system and service manager that includes features like on-demand starting of daemons, mount and automount point maintenance, snapshot support, and process tracking using Linux control groups. `systemd` also provides a logging daemon and other tools and utilities to hep with common system administration tasks (*linode*).

---

## Create a `systemd` Service

Write a file that describes the service in the `systemd` format to `/etc/systemd/system/$NAME_OF_SERVICE.service`.

Below is a simple example service. See the [systemd man page](https://www.freedesktop.org/software/systemd/man/systemd.timer.html) for all the available options.

```ini
[Unit]
Description=$DESCRIPTION_OF_SERVICE

[Service]
Type=simple
Restart=always
RestartSec=$INTERVAL_AFTER_RESTART_IN_SECONDS
User=$TARGET_USERNAME
ExecStart=$COMMAND_TO_EXECUTE
```

`$INTERVAL_AFTER_RESTART_IN_SECONDS` is the number of seconds to wait before restarting the service if it fails. If this is too low a value (like 1), `systemd` will eventually stop the program. Keep it to 5 seconds or greater.

---

## Start a `systemd` Service

```bash
systemctl start $NAME_OF_SERVICE
```

```bash
service $NAME_OF_SERVICE start
```

---

## Configure a `systemd` Service to Start on Boot

```bash
systemctl enable $NAME_OF_SERVICE
```

---

## Stop a `systemd` Service

```bash
systemctl stop $NAME_OF_SERVICE
```

```bash
service $NAME_OF_SERVICE stop
```

---

## Schedule a `systemd` Timer

Write a `systemd` timer file in the `systemd` format to `/etc/systemd/system/$NAME_OF_SERVICE.timer`.

Below is an example that first runs the service 5 minutes after boot and then every 3 minutes thereafter. Modify `OnBootSec` and `OnUnitActiveSec` accordingly. See the [systemd man page](https://www.freedesktop.org/software/systemd/man/systemd.timer.html) for all the available options.

```ini
[Unit]
Description=$DESCRIPTION_OF_SERVICE

[Timer]
OnBootSec=5min
OnUnitActiveSec=3min
Unit=$NAME_OF_SERVICE

[Install]
WantedBy=multi-user.target
```

Start the timer.

```bash
systemctl start $NAME_OF_SERVICE.timer
```

Optionally enable the timer to start on boot.

```bash
systemctl enable $NAME_OF_SERVICE.timer
```

---

## References

[Wikipedia - Systemd](https://en.wikipedia.org/wiki/Systemd)

[systemd Man Page](https://man7.org/linux/man-pages/man1/systemd.1.html)

[FreeDesktop.org - systemd timer Man Page (contains service and timer file options)](https://www.freedesktop.org/software/systemd/man/systemd.timer.html)

[linode - What is systemd?](https://www.linode.com/docs/guides/what-is-systemd/)

[@benmorel - Creating a Linux Service with systemd](https://medium.com/@benmorel/creating-a-linux-service-with-systemd-611b5c8b91d6)

