# [patator](https://github.com/lanjelot/patator)

> A multi-threaded Python protocol brute forcer.

## Input Formats

`patator` has three major methods of feeding input lists for fuzzing: `COMBO`, `FILE`, and `RANGE`. They can be mixed and matched, as needed.

### COMBO

The `COMBO` input method allows you to input one or more files, each of which has a "combination" of values on each line separated by a delimiter (default is `:`). `patator` will iterate over the cartesian product of the files and send one request per tuple. If you have three input files with X, Y, and Z lines respectively, `patator` will send X x Y x Z requests.

For example, let's say you are brute-forcing a web application login and have a particular set of username and password pairs that go together and you also want to submit a different IP address in each request's `X-Forwarded-For` header. Your `COMBO` file would look like:

```txt
username1:password1:10.6.10.20
username2:password2:10.6.10.30
username3:password3:10.6.10.40
username4:password1:10.6.10.40
...[SNIP]...
```

and your `patator` command would be:

```bash
patator http_fuzz url=$URL body='username=COMBO00&password=COMBO01' header='X-Forwarded-For: COMBO02' 0=combos.txt -x ignore:fgrep="Incorrect credentials"
```

Key parts:

- `0=combos.txt`
	- The file `combos.txt` will correspond to `COMBO0_` throughout the command

- `username=COMBO00`:
	- COMBO<u>0</u>0: Designates that the value is to be taken from the `COMBO` file passed into argument `0` (`combos.txt`)
	- COMBO0<u>0</u>: Designates that the value is to be taken from the 0th (first) index of values on the line, separated by the delimiter (`:`)

- `password=COMBO01`:
	- COMBO<u>0</u>1: Designates that the value is to be taken from the `COMBO` file passed into argument `0` (`combos.txt`)
	- COMBO0<u>1</u>: Designates that the value is to be taken from the 1st (second) index of values on the line, separated by the delimiter (`:`)

- `X-Forwarded-For: COMBO2`:
	- COMBO<u>0</u>2: Designates that the value is to be taken from the `COMBO` file passed into argument `0` (`combos.txt`)
	- COMBO0<u>2</u>: Designates that the value is to be taken from the 2nd (third) index of values on the line, separated by the delimiter (`:`)

Multiple `COMBO` files can be used, as well.

### FILE

The `FILE` input method allows you to input one or more files, each of which has has a single value on each line. `patator` will iterate over the cartesian product of the files and send one request per tuple. If you have three input files with X, Y, and Z lines respectively, `patator` will send X x Y x Z requests.

For example, let's say you are brute-forcing a web application login with a list of usernames and passwords that aren't paired up already. Your files might look like:

```txt
username1
username2
username3
...[SNIP]...
```

```txt
password1
password2
password3
...[SNIP]...
```

and your `patator` command might look like:

```bash
patator http_fuzz url=$URL body='username=FILE0&password=FILE1' 0=users.txt 1=passwords.txt -x ignore:fgrep='Invalid username or password'
```

Key parts:

- `0=users.txt`:
	- The file `users.txt` will correspond to `FILE0` throughout the command

- `1=passwords.txt`:
	- The file `passwords.txt` will correspond to `FILE1` throughout the command

- `username=FILE0`:
	- Use the value from whatever line the iterator is currently on in `FILE0`

- `password=FILE1`:
	- Use the value from whatever line the iterator is currently on in `FILE1`

---

## RANGE

The `RANGE` input method allows you to iterate over ranges of numbers. `patator` will iterate over the cartesian product of the ranges and send one request per tuple. If you have three input ranges with X, Y, and Z lines respectively, `patator` will send X x Y x Z requests.

Example:

```bash
patator http_fuzz body='number=RANGE0&letter=RANGE1' 0=int:0-500 1=lower=a-zzz
```

---

## PROG

The `PROG` input method allows you to iterate over the output of an external program.

Example:

```bash
patator http_fuzz url='http://intelligence.htb/documents/PROG0-PROG1-PROG2-upload.pdf' 0='for i in {2019..2021}; do echo $i; done' 1='for i in  {01..12}; do echo $i; done' 2='for i in {01..31}'
```

---

## Repeat the Same Request `$N` Times

```bash
patator http_fuzz url=$URL method=$METHOD header='X-Iteration: RANGE0' body='username=tgihf&password=blah' 0=int:1-$N
```

---

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

## Brute force HTTP login form based on failure string

```bash
patator http_fuzz url=$URL method=$METHOD [header='$HEADER'] body='$HTTP_BODY' 0=$FILE0 -x ignore:fgrep='$FAILURE_STRING'
```

## Brute force HTTP login form based on HTTP code

```bash
patator http_fuzz url=$URL method=$METHOD [header='$HEADER']  body='$HTTP_BODY' 0=$FILE0 -x ignore:code=$FALURE_CODE
```

## Brute force HTTP request based on Content Length

```bash
patator http_fuzz url=$URL method=$METHOD $OTHER_ARGUMENTS -x ignore:clen=$CONTENT_LENGTH
```

- `$CONTENT_LENGTH` can be range, check usage for details

---

## Brute Force SSH - Single Username

```bash
patator ssh_login host=$HOST port=$PORT user=$USERNAME password=FILE0 0=$PATH_TO_PASSWORDS_FILE -x ignore:mesg='Authentication failed.'
```

---

## Brute Force SSH - Multiple Usernames

```bash
patator ssh_login host=$HOST port=$PORT user=FILE0 password=FILE1 0=$PATH_TO_USERS_FILE 1=$PATH_TO_PASSWORDS_FILE -x ignore:mesg='Authentication failed.'
```
