# L33tLinked

LinkedIn scraping tool that utilizes Google and Bing to to grab LinkedIn profile first names, last names, and email addresses.

## Generate list of employees at $COMPANY with $EMAIL_FORMAT on $EMAIL_DOMAIN

* $COMPANY_NAME is only used for writing output and isn't significant for retrieving data, so don't worry about getting it just right
  * "SixGen, LLC"
* $EMAIL_FORMAT is an integer from the list in this document
  * 3
* $EMAIL_DOMAIN
  * sixgen.io
* Output is an Excel document

```bash
source /usr/share/LeetLinked/venv-leetlinked/bin/activate
cd /usr/share/leetlinked
python3 leetlinked.py -e $EMAIL_DOMAIN -f $EMAIL_FORMAT $COMPANY_NAME
```

## Email formats

```text
1=jsmith
2=johnsmith
3=johns
4=smithj
5=john.smith
6=smith.john
7=smith
```
