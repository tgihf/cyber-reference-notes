# nmap - *de facto network scanner*

## Targeted scan of *\<ports\>* on *\<target\>*

* *$PORTS* is a comma-separated list of port numbers or a range
  * Example: 80,443,445 or 1-1000

```bash
nmap -sC -sV -O -p$PORTS $TARGET -oA $OUTPUT_FILENAME
```
