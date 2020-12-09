# masscan - *remote scanner for comprehensive, loud scanning*

## Open port discovery of *\<target\>*

```bash
masscan -p1-65535,U:1-65536 $TARGET_IP --rate=1000 -e $INTERFACE --output-format $OUTPUT_FORMAT --output-filename $OUTPUT_FILENAME
```

* *$OUTPUT_FORMAT* options
  * xml
  * binary
  * grepable
  * json
  * list

## Extract comma-separated list of ports from masscan output

```bash
cat <masscan output> | grep "open port" | cut -d' ' -f4 | cut -d'/' -f1 | tr '\n' ','
```
