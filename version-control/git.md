# [git](https://git-scm.com/)

> The de facto tool for decentralized version control.

---

## Dump `.git` Directory from URL

[GitTools](https://github.com/internetwache/GitTools)

```bash
gitdumper.py $URL $OUTPUT_DIRECTORY
```

- `$URL` must end in `/.git/`

---

## View Order of Repository's Commits

```bash
cat .git/logs/HEAD
```

---

## Recover Repository & Commits from `.git` Directory

[GitTools](https://github.com/internetwache/GitTools)

```bash
extractor.sh $PATH_TO_.GIT_DIRECTORY $OUTPUT_DIRECTORY
```
