# wfuzz - web application fuzzer

## Fuzz the URI of a web application with a word list

```bash
wfuzz -c -z file,$WORDLIST --hw $NUMBER_OF_WORDS_IN_REQUESTS_WE_WANT_TO_HIDE $URL # $URL -> https://target.com/api/FUZZ
```

Wherever the word *FUZZ* is in the target URI is what will be fuzzed.

## Fuzz the body of an HTTP POST form with a word list

Let's say our form has two parameters:

* username
* password

```bash
wfuzz -c -z file,$WORDLIST -x POST -d "username=FUZZ&password=FUZZ" --hw $NUMBER_OF_WORDS_IN_REQUESTS_WE_WANT_TO_HIDE $URL # URL -> https://target.com/login
```
