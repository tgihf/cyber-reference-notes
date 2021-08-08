# [Mount NFS Mountpoint](https://linuxize.com/post/how-to-mount-an-nfs-share-in-linux/)

1. Install the necessary dependencies (from above link)

2. Create a directory to mount the NFS filesystem to

```bash
mkdir mount-point
```

3. Mount the NFS filesystem to the directory

```bash
sudo mount -t nfs $TARGET:$MOUNTPOINT mount-point
```

i.e.,

```bash
mkdir backups
sudo mount -t nfs 10.10.10.10:/var backups
```