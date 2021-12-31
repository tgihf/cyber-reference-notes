# Writable SMB Paths

> Writable paths on an SMB share can be exploited in a variety of useful ways.

---

## Determine Writable Paths on an SMB Share

Mount the SMB share.

```bash
sudo mount -t cifs //$SMB_SERVER_FQDN_OR_IP/$SHARE $LOCAL_MOUNT_PATH
```

When prompted for a password, just hit enter.

Drop into a `root` shell (`sudo bash`) and run the following.

```bash
$ cd $LOCAL_MOUNT_PATH
$ find . -type d | while read directory; do touch ${directory}/tgihf 2>/dev/null && echo "${directory} - write file" && rm ${directory}/tgihf; mkdir ${directory}/tgihf 2>/dev/null && echo "${directory} - write dir" && rmdir ${directory}/tgihf; done
```

When you're finished, unmount the share.

```bash
sudo umount $LOCAL_MOUNT_PATH
```

---

## Write a SCF File to a Public SMB Share to Potentially Capture Someone's Hash

[[scf-files]]
