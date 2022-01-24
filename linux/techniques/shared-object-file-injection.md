# Shared Object File Injection

Executables often import shared object files to use their functionality. Sometimes these shared object files don't exist and the import fails. If you replace the nonexistent shared object file with your own, you could execute arbitrary code in the context of the owner of the executable.

### Process

1. Find some executable that generally runs in an elevated context (via `sudo`, `SUID`, `cron`, `systemd` timer, etc.)
2. For each executable that runs in an elevated context:
	- [[strace#Looking for Failed Shared Object File Imports|Determine the executable's shared object import failures]]
3. For each failed shared object file import:
	- Check your permissions on the target file or its directory. If you can replace it:
		- Replace it with a [[so-source|malicious shared object file]]
		- When the executable runs, your malicious shared object file will also run.
