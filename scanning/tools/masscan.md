# masscan

Remote scanner for quick, comprehensive, and loud scanning.

## Open port discovery of $TARGET

```bash
masscan -p1-65535,U:1-65536 $TARGET_IP --rate=1000 -e $INTERFACE --output-format $OUTPUT_FORMAT --output-filename $OUTPUT_FILENAME
```

- *$OUTPUT_FORMAT* options
  - xml
  - binary
  - grepable
  - json
  - list

## Extract comma-separated list of ports from grepable masscan output

```bash
cat $MASSCAN_OUTPUT  | grep open | cut -d' ' -f5 | cut -d'/' -f1 | sort -u | tr '\n' ','
```
