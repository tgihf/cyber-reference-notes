# Using Kerberos Tickets in `impacket`

---

## Importing a Kerberos Ticket into `impacket`

Kerberos tickets are generally written to disk with the extension `.ccache`. To use them with `impacket` tools, export the path of the file into the environment variable `KRB5CCNAME`.

```bash
export KRB5CCNAME='$PATH_TO_TICKET.ccache'
```

---

## Using Kerberos Tickets in `impacket` Tools

Most `impacket` tools will take the flags `-k` and `-no-pass` to use Kerberos authentication.
