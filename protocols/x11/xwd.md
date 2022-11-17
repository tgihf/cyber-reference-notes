> Dump an image of an X window.

---

## Dump an Image of an X Window

```bash
xwd -root -screen -silent -display :$DISPLAY_NUMBER > $PATH_TO_OUTPUT_FILE
```

- Example `$DISPLAY_NUMBER`: `0` (so `-display :0`)
- Note that the output cookie is in binary format and if you need to transfer it around, either base64 encode and copy and paste it or transfer the binary file itself

---

## Authorization

Note that as an X11 client program, `xwd` will leverage [[x11-authorization#Cookie-based Access|X11 cookie-based authorization]] if possible.

---

## References

[xwd Man Page](https://linux.die.net/man/1/xwd)