# nmap - *de facto network scanner*

## Targeted scan of *\<ports\>* on *\<target\>*

* *\<ports\>* is a comma-separated list of port numbers
  * Example: 80,443,445

```bash
nmap -sC -sV -O -p<ports> <target> -oA <output filename>
```
