# Privilege Escalation via NFS No `root` Squashing Misconfiguration

> `no_root_squash` is a configuration you can place on an [[nfs|NFS]] share. If `root` on a client machine mounts an NFS share configured with `no_root_squash`, they can perform file system actions within the NFS share as `root` on the NFS server machine.

---

## NFS No `root` Squashing Privilege Escalation Process

1. Determine if the target is serving NFS shares and if any of the shares are configured with `no_root_squash`
	- See [[nfs-no-root-squashing#Check if a Target is Serving NFS Shares with no_root_squash Enabled|here]]
2. For each share configured with `no_root_squash`:
	- Confirm you can reach the target share from your attacking machine:
		- [[list-mounts|List a Server's NFS Shares]]
3. For each share configured with `no_root_squash` that you can reach:
	- [[su]] to `root` on your attacking machine
	- [[mount-mountpoint|Mount the share]]
	- Write a malicious payload into the share
		- i.e., an [[elf-source|ELF]]
	- Set the malicious payload's SUID bit
	- [[mount-mountpoint#Unmount a Mounted Mount Point|Unmount the share]]
4. As a local, low-privileged user on the target:
	- Confirm the malicious payload is owned by `root` and has the SUID bit set
	- If the above is true, execute the payload and profit

---

## Check if a Target is Serving NFS Shares with `no_root_squash` Enabled

On the target machine, take a look at the `/etc/exports` file.

```bash
cat /etc/exports
```

Here's an example from TCM Security's Linux Privilege Escalation Course:

```txt
# /etc/exports: the access control list for filesystems which may be exported
#               to NFS clients.  See exports(5).
#
# Example for NFSv2 and NFSv3:
# /srv/homes       hostname1(rw,sync,no_subtree_check) hostname2(ro,sync,no_subtree_check)
#
# Example for NFSv4:
# /srv/nfs4        gss/krb5i(rw,sync,fsid=0,crossmnt,no_subtree_check)
# /srv/nfs4/homes  gss/krb5i(rw,sync,no_subtree_check)
#

/tmp *(rw,sync,insecure,no_root_squash,no_subtree_check)
```

It begins with a block of comments. After the block of comments, each NFS share is on its own line, followed by a list of configurations for that share.

In this example, the server is serving `/tmp` as an NFS share with the `rw`, `sync`, `insecure`, `no_subtree_check`, and `no_root_squash` configurations enabled.

The presence of the `no_root_squash` configuration in this list is the indicator we're looking for.
