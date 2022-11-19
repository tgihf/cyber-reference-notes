# [git](https://git-scm.com/)

> The de facto tool for decentralized version control.

---

## Clone a Repository

```bash
git clone $REPOSITORY_URL
```

---

## Dump `.git` Directory from URL

[GitTools](https://github.com/internetwache/GitTools)

```bash
gitdumper.py $URL $OUTPUT_DIRECTORY
```

- `$URL` must end in `/.git/`

---

## View Repository's Commits

```bash
git log
```

---

## Show a Commit's Changes

```bash
git show $COMMIT_HASH
```

- `$COMMIT_HASH` uniquely identifies a commit and can be found when [[git#View Repository's Commits|viewing the repository's commits]]

---

## Recover Repository & Commits from `.git` Directory

[GitTools](https://github.com/internetwache/GitTools)

```bash
extractor.sh $PATH_TO_.GIT_DIRECTORY $OUTPUT_DIRECTORY
```
