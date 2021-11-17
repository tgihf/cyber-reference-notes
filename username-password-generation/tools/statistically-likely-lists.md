# Username and Password Lists for Password Spraying

---

## Username Lists

The tool [Spray](https://github.com/Greenwolf/Spray) comes with a preconfigured list of the statisically most-likely usernames based off of millions of names on Facebook for different countries.

These lists come in different formats, such as:

```bash
jsmith
john.smith
johnsmith
etc
```

and can be found in:

```bash
/usr/share/Spray/name-lists/statistically-likely-usernames
```

Choose the username list that fits the format of the target's usernames, or create your own to do so.

---

## Password Lists

[Spray](https://github.com/Greenwolf/Spray) comes with a list of the most commonly used passwords in various languages based off the time of year. These can be found in:

```bash
/usr/share/Spray/password-lists
```

---

## Update Password List

[Spray's](https://github.com/Greenwolf/Spray) password lists are updated regularly. To update a particular list, run the following:

```bash
spray -passupdate $PATH_TO_PASSWORD_LIST_TO_UPDATE # /usr/share/Spray/password-lists/passwords-English.txt
```

---

## Generate Custom Username List

```bash
spray.sh -genusers $FIRST_NAME_LIST $LAST_NAME_LIST "<<fi><li><fn><ln>>"
```

Example:

```bash
spray -genusers english-first-1000.txt english-last-1000.txt "<fi><ln>"
```
