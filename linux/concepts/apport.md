# [Apport](https://wiki.ubuntu.com/Apport)

> A Ubuntu subsystem which intercepts program crashes right when they happen, gathers potentially useful information about the crash (including a [[core-dump|core dump]]) and the operating system environment.

---

## Crash Reports Location

By default, `Apport` stores crash reports in a plain text file of key value pairs at `/var/crash/$FILE_PATH.$USER_ID.crash`, where `$FILE_PATH` is the path of the program with underscores replacing the forward slashes and `$USER_ID` is the ID of the user who invoked the program.

---

## Unpack Crash Report

Each Apport crash report file just contains key/value pairs. To unpack these key value pairs into a directory of files, one file per key/value pair:

```bash
apport-unpack $PATH_TO_CRASH_REPORT $OUTPUT_DIRECTORY
```

---

## Memory Dumps Location

By default, `Apport` stores memory dumps in a binary file named `CoreDump` in an **unpacked** crash report directory.

