# patator - protocol brute forcer

## HTTP brute force *body* format

If you want to brute force the following HTTP body:

```bash
username=tgihf&password=password123&foo=bar
```

Then the *body* paramter of patator will be:

```bash
body='username=COMBO00&password=COMBO01&foo=bar'
```

## HTTP brute force combo file format

The format of the combination file should be:

```bash
user1:pass1
user2:pass2
user3:pass3
...
usern:passn
```

## Brute force HTTP login form based on failure string

```bash
patator http_fuzz url=$URL method=$METHOD body='$HTTP_BODY' 0=$COMBO_FILE -x ignore:fgrep='$FAILURE_STRING'
```

## Brute force HTTP login form based on HTTP code

```bash
patator http_fuzz url=$URL method=$METHOD body='$HTTP_BODY' 0=$COMBO_FILE -x ignore:code=$FALURE_CODE
```
