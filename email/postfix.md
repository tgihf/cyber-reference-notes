# [postfix](https://www.google.com/search?client=firefox-b-e&q=postfix)

---

## [Content Filter Scripts](https://book.hacktricks.xyz/pentesting/pentesting-smtp#postfix)

If postfix is installed, `/etc/postfix/master.cf` contains scripts to run when a user receives a new email. For example, the line

```txt
flags=Rq user=mark argv=/etc/postfix/filtering -f ${sender} -- ${recipient}`
```

denotes that `mark` will execute `/etc/postfix/filtering` whenever `mark` receives an email.

`/etc/postfix/sendmail.cf` and `/etc/postfix/submit.cf` may also contain scripts to run.
