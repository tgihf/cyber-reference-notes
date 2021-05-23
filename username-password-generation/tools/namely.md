# [namely](https://github.com/OrielOrielOriel/namely)

> Extensible email address generator.

## Generate email address list based on single name, domain, and template

* $NAME
  * "hunter friday"
* $DOMAIN
  * "sixgen.io"
* $TEMPLATE
  * "\\${first}.\\${last}@\\${domain}"
    * hunter.friday@sixgen.io
  * "\\${first1}\\${last}@\\${domain}"
    * hfriday@sixgen.io
  * "\\${first1}\\${last1}@\\${domain}"
    * hf@sixgen.io

```bash
namely -n $NAME -d $DOMAIN -t $TEMPLATE
```

## Generate email address list based on multiple names, domains, and templates

```bash
namely -nf $NAME_FILE -df $DOMAIN_FILE -tf $TEMPLATE_FILE
```

```text
# example name file
hunter friday
Hunter Friday
```

```text
# example domain file
renditioninfosec.com
sixgen.io
```

```text
# example template file
${first}.${last}@${domain}
${first1}${last}@${domain}
${first1}${last1}@${domain}
```

## Use arbitrary key values in generated email addresses

```bash
namely -nf $NAME_FILE -d $DOMAIN -k $KEY_NAME $KEY_VALUES_FILE -t "\${first1}\${last1}\${$KEY_NAME}@\${domain}"
```

```text
# example key values file for three digit numbers
000
001
002
003
...
999
```
