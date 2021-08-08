# [patator](https://github.com/lanjelot/patator)

> A multi-threaded Python protocol brute forcer.

## HTTP brute force *body* format

If you want to brute force the following HTTP body:

```txt
username=tgihf&password=password123&foo=bar
```

Then the *body* paramter of patator will be:

```txt
body='username=FILE0&password=FILE1&foo=bar'
```

---

## HTTP brute force file format

Each file should have one word per line.

---

## Brute force HTTP login form based on failure string

```bash
patator http_fuzz url=$URL method=$METHOD body='$HTTP_BODY' 0=$FILE0 -x ignore:fgrep='$FAILURE_STRING'
```

## Brute force HTTP login form based on HTTP code

```bash
patator http_fuzz url=$URL method=$METHOD body='$HTTP_BODY' 0=$FILE0 -x ignore:code=$FALURE_CODE
```
