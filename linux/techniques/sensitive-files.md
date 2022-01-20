# Sensitive Files on Linux

---

## Users

All users are stored in [[etc-passwd|/etc/passwd]] Some password hashes may be stored in here as well. If a user's password hash is stored here, the system won't look at [[etc-shadow|/etc/shadow]] when checking access permissions.

With `READ` access, you may be able to read a user's hash and attempt to crack it offline. By default, all users have `READ` access.

With `WRITE` access, you can write a user's hash and then log in as them using the corresponding password. You can also change the current user's group ID to one with elevated privileges. By default, all users **do not** have `WRITE` access.

---

## Groups

All group are stored in `/etc/groups`. Some password hashes may be stored in here as well.

---

## Password Hashes

The password hashes of all users are stored in [[etc-shadow|/etc/shadow]].

With `READ` access, you can read the users' hashes and attempt to crack them offline. By default, alll users **do not** have `READ` access.

With `WRITE` access, you can write a user's hash and then log in as them using the corresponding password. By default, all users **do not** have `WRITE` access.
 
 ---
 
 ## SSH Keys
 
 If you can find an SSH private key, you may be able to use it to log in as another user.
 
 See [[credential-hunting#SSH Keys|here]].
 