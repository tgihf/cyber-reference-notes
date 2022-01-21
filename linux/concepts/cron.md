# [cron](https://en.wikipedia.org/wiki/Cron)

> A job scheduler on Unix-like operating systems, allowing users to run commands periodically at fixed times, dates, or intervals.

---

## Cron Format

Cron jobs are formatted in a particular way to describe their execution frequency, command(s), and environment variables. This format is describe in a comment in all cron files.

The format is:

```txt
$ENVIRONMENT_VARIABLE_1=$ENVIRONMENT_VARIABLE_1_VALUE
$ENVIRONMENT_VARIABLE_N=$ENVIRONMENT_VARIABLE_N_VALUE

$MINUTE $HOUR $DAY_OF_MONTH $MONTH $DAY_OF_WEEK $USER $COMMAND
```

- `$MINUTE`: (0 - 59 or `*` for every)
- `$HOUR`: (0 - 23 or `*` for every)
- `$DAY_OF_MONTH`: (1 - 31 or `*` for every)
- `$MONTH`: (1 - 12 or `*` for every)
- `$DAY_OF_WEEK`: (0 - 6) or (sun,mon,tue,wed,thu,fri,sat) or `*` for every
- `$USER`: user to run `$COMMAND` as

### Examples

This cron job runs as `tgihf` every minute.

```txt
# m h dom mon dow user  command
  * *   *   *   * tgihf /home/tgihf/download-updates.sh && echo 'Downloaded Updates!' > /home/tgihf/Desktop/statuses.txt
```

This cron job runs as `root` every Sunday, Monday, and Tuesday at 4:30 PM.

```txt
# m   h dom mon         dow user command
  30 16   *   * sun,mon,tue root /root/download-updates.sh 2>/dev/null 
```

---

## View Configured Cron Jobs

### View the Current User's Configured Cron Jobs

```bash
crontab -l
```

### View System-Wide Configured Cron Jobs

Check these files and directories.

```bash
/etc/crontab
/etc/init.d
/etc/cron*
/etc/cron.allow
/etc/cron.d 
/etc/cron.deny
/etc/cron.daily
/etc/cron.hourly
/etc/cron.monthly
/etc/cron.weekly
/etc/sudoers
/etc/exports
/etc/anacrontab
/var/spool/cron
/var/spool/cron/crontabs/root
```
