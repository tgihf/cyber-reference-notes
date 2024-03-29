# [Mount NFS Mountpoint](https://linuxize.com/post/how-to-mount-an-nfs-share-in-linux/)

1. Install the necessary dependencies (from above link)

2. Create a directory to mount the NFS filesystem to

```bash
mkdir mount-point
```

3. Mount the NFS filesystem to the directory

```bash
sudo mount -t nfs [-o rw,vers=2] $TARGET:$MOUNTPOINT mount-point
```

i.e.,

```bash
mkdir backups
sudo mount -t nfs -o rw,vers=2 10.10.10.10:/var backups
```

---

## Unmount a Mounted Mount Point

```bash
sudo umount $LOCAL_MOUNT_POINT
```

---

## NFS Impersonation

NFS enforces authorization on a filesystem, user ID, and group ID basis.

For example, assume you mount a remote mount point that is writable by a remote user with the ID `2000` and by a remote group with the ID `3000`. If you [[useradd#Create New User|create a local user with the same user and/or group ID]], you'll be able to write to the remote mount point.

