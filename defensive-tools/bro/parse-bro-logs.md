# Parsing Bro Log Files

## View Column Names

```bash
head $BRO_LOG_FILE | less
```

## Filter for Particular Columns

```bash
cat $BRO_LOG_FILE | bro-cut $COLUMN_1 [$COLUMN_2 [$COLUMN_N]]
```
