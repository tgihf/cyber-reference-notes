# Disk Interaction in Linux

## List Disks & Partitions

```bash
lsblk
```

## List Disks & Mount Points

```bash
df
```

## Wipe Disk with Zeroes

```bash
dc3dd $DEVICE_PATH
```

* Example `$DEVICE_PATH`: `/dev/sdb`

## Wipe Disk with Hex Pattern

```bash
dc3dd $DEVICE_PATH pat=$HEX_PATTERN
```

* Example `$HEX_PATTERN`: `1234abcd`

## Wipe Disk with Text Pattern

```bash
dc3dd $DEVICE_PATH tpat=$TEXT_PATTERN
```

* Example `$TEXT_PATTERN`: `'Media wiped on 20210407'`
