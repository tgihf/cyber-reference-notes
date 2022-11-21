# awk

> Pattern scanning and processing language

> The `awk` utility shall execute programs written in the `awk` programming language, which is specialized for textual data manipulation. An `awk` program is a sequence of patterns and corresponding actions. When input is read that matches a pattern, the action associated with that pattern is carried out.

---

## How It Works

### Records

Input is interpreted as a sequence of records. By default, a record is a line, less its terminating newline (note this can be changed by using the `RS` built-in variable). Each record of the input shall be matched in turn against each pattern in the program. For each pattern matched, the corresponding action shall be executed.

For example, the following input has two records:

```txt
one:two:three
four:five:six
```

### Fields

Each record is interpreted as a sequence of fields where, by default, a field is a string of non-blank non-newline characters (note this default field delimeter can be changed by using the `FS` built-in variable or the `-F $FIELD_SEPARATOR` option). In the `awk` program, the first field of each record can be retrieved with `$1`, the second `$2`, and so on. The symbol `$0` shall refer to the whole record.

For example, the following input has two records, each with three fields delimited by `-`. For the first record, `$0` = `one-two-three`, `$1` = `one`, `$2` = `two`, and `$3` = `three`.

```txt
one-two-three
four-five-six
```

### General Syntax

```bash
awk [-F '$FIELD_SEPARATOR'] '[$AWK_PATTERN ]{$AWK_ACTION}' $PATH_TO_INPUT_FILE
```

- `$FIELD_SEPARATOR` defaults to a space
- `$AWK_PATTERN`: see [[awk#`$AWK_PATTERN`s|here]] for examples
- `$AWK_ACTION`: see the various `$AWK_ACTION` sections in this file for examples

---

## `$AWK_PATTERN`s

### Exact Match Conditions

- `$FIELD == "$VALUE"`
- `$FIELD != "$VALUE"`
- `$FIELD` (if not blank)

### Regex Match Conditions

- `$FIELD ~ /$REGEX/`
- `$FIELD !~ /$REGEX/`
- `/$REGEX/` (evaluate entire record)

### Numeric Conditions

- `$FIELD < $VALUE`
- `$FIELD <= $VALUE`
- `$FIELD > $VALUE`
- `$FIELD >= $VALUE`

### Compound Conditions

- `$CONDITION_1 && $CONDITION_2`
- `$CONDITION_1 || $CONDITION_2`

---

## `$AWK_ACTION`: Print Field(s)

```bash
print $FIELD_1[,$FIELD_2[,$FIELD_N]]
```

For example, to print the first and third fields of all matched records separated by a space:

```bash
awk '[$AWK_PATTERN ]{print $1, $3}' $PATH_TO_INPUT_FILE
```

---

## `$AWK_ACTION`: Print Fields with Custom Delimeter

```bash
print $FIELD_1 "$DELIMETER" $FIELD_2 ["$DELIMETER" $FIELD_N]
```

For example, to print the first, third, and sixth fields of all matched records with `:` as the delimeter:

```bash
awk '[$AWK_PATTERN ]print $1 ":" $3 ":" $6' $PATH_TO_INPUT_FILE
```

---

## Example Input File

From [Hack the Box's StreamIO](https://app.hackthebox.com/machines/StreamIO).

```txt
admin:665a50ac9eaa781e4f7f04199db97a11:paddpadd
Alexendra:1c2b3d8270321140e5153f6637d3ee53
Austin:0049ac57646627b8d7aeaccf8b6a936f
Barbra:3961548825e3e21df5646cafe11c6c76
Barry:54c88b2dbd7b1a84012fabc1a4c73415:$hadoW
Baxter:22ee218331afd081b0dcd8115284bae3
Bruno:2a4e2cf22dd8fcb45adcb91be1e22ae8:$monique$1991$
Carmon:35394484d89fcfdb3c5e447fe749d213
Clara:ef8f3d30a856cf166fb8215aca93e9ff:%$clara
Diablo:ec33265e5fc8c2f1b0c137bb7b3632b5
Garfield:8097cedd612cc37c29db152b6e9edbd3
Gloria:0cfaaaafb559f081df2befbe66686de0
James:c660060492d9edcaa8332d89c99c9239
Juliette:6dcd87740abb64edfa36d170f0d5450d:$3xybitch
Lauren:08344b85b329d7efd611b7a7743e8a09:##123a8j8w5123##
Lenord:ee0b8a0937abd60c2882eacb2f8dc49f:physics69i
Lucifer:7df45a9e3de3863807c026ba48e55fb3
Michelle:b83439b16f844bd6ffe35c02fe21b3c0:!?Love?!123
Oliver:fd78db29173a5cf701bd69027cb9bf6b
Robert:f03b910e2bd0313a23fdd7575f34a694
Robin:dc332fb5576e9631c9dae83f194f8e70
Sabrina:f87d3c0d6c8fd686aacc6627f1f493a5:!!sabrina$
Samantha:083ffae904143c4796e464dac33c1f7d
Stan:384463526d288edcc95fc3701e523bc7
Thane:3577c47eb1e12c8ba021611e1280753c:highschoolmusical
Theodore:925e5408ecb67aea449373d668b7359e
Victor:bf55e15b119860a6e6b5a164377da719
Victoria:b22abb47a02b52d5dfa27fb0b534f693:!5psycho8!
William:d62be0dc82071bccc1322d64ec5b6c51
yoshihide:b779ba15cedfd22a023c4d8bcf5f2332:66boysandgirls..
```

---

## References

[awk Man Page](https://man7.org/linux/man-pages/man1/awk.1p.html)
