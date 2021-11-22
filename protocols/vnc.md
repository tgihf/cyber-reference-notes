# [Virtual Network Computing](https://en.wikipedia.org/wiki/Virtual_Network_Computing)

> A graphical desktop-sharing system that uses the Remote Frame Buffer protocol (RFB) to remotely control another computer. It transmits the keyboard and mouse input from one computer to another, relaying the graphical-screen updates, over a network.

---

## Decrypt a VNC Password

Most VNC software stores its passwords encrypted with a fixed, publicly available encryption key. [This Github repository](https://github.com/frizb/PasswordDecrypts) contains information on where to find and how to decrypt these passwords. Here's an effective way from this repository:

```bash
$ echo -n $VNC_PASSWORD | xxd -r -p | openssl enc -des-cbc --nopad --nosalt -K e84ad660c4721ae0 -iv 0000000000000000 -d | hexdump -Cv
```

- `$VNC_PASSWORD` example: `6bcf2a4b6e5aca0f`
