# Default `SUID` Executables on Debian

```bash
$ find / -user root -perm -4000 -print 2>/dev/null
/usr/bin/chfn
/usr/bin/chsh
/usr/bin/gpasswd
/usr/bin/newgrp
/usr/bin/passwd
/usr/bin/su
/usr/bin/mount
/usr/bin/umount
/usr/bin/fusermount
/usr/bin/pkexec
/usr/bin/sudo
/usr/bin/ntfs-3g
/usr/lib/dbus-1.0/dbus-daemon-launch-helper
/usr/lib/openssh/ssh-keysign
/usr/libexec/polkit-agent-helper-1
/usr/sbin/pppd
/usr/sbin/exim4