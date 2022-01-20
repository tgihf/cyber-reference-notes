# Sensitive Files on Linux

---

## Users (`/etc/passwd`)

All users are stored in [[etc-passwd|/etc/passwd]] Some password hashes may be stored in here as well. If a user's password hash is stored here, the system won't look at [[etc-shadow|/etc/shadow]] when checking access permissions.

With `READ` access, you may be able to read a user's hash and attempt to crack it offline. By default, all users have `READ` access.

With `WRITE` access, you can write a user's hash and then log in as them using the corresponding password. You can also change the current user's group ID to one with elevated privileges. By default, all users **do not** have `WRITE` access.

---

## Groups (`/etc/group`)

All group are stored in `/etc/group`. Some password hashes may be stored in here as well.

With `WRITE` access, you can add the current user to any group you want by appending its username to the end of that group's line, like so:

```bash
$ cat /etc/group | sed 's/root:x:0:/root:x:0:tgihf/g' | head -n 1
root:x:0:tgihf
```

---

## Password Hashes (`/etc/shadow`)

The password hashes of all users are stored in [[etc-shadow|/etc/shadow]].

With `READ` access, you can read the users' hashes and attempt to crack them offline. By default, alll users **do not** have `READ` access.

With `WRITE` access, you can write a user's hash and then log in as them using the corresponding password. By default, all users **do not** have `WRITE` access.
 
 ---
 
 ## SSH Keys (`/home/$USERNAME/.ssh/id_(.+$)`)
 
 If you can find an SSH private key, you may be able to use it to log in as another user.
 
 Each user's SSH private key is generally found at `/home/$USERNAME/.ssh/id_(dsa|rsa|ecda|ed25519)`. `root`'s, of course, can be found at `/root/.ssh/id_(dsa|rsa|ecda|ed25519)`.
 
 System SSH keys can also be found at `/etc/ssh/ssh_host_(dsa|rsa|ecda|ed25519)_key`.
 
 See [[credential-hunting#SSH Keys|here]].
 