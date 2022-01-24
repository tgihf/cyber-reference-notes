# Shell Profiles

When a shell is invoked, it reads and executes particular initialization files to setup the environment within which it will run. These initialization files are referred to as shell profiles.

## Two Types of Shell Profiles

1. The system-wide shell profile that applies to all shells unless overridden by a user-specific shell profile. These profiles are only writable by `root`.

	- `/etc/profile`
	- `/etc/bash.bashrc`

2. User-specific shell profiles whose existence overrides the system-wide shell profile. These profiles are only writable by `$USERNAME`.

	- `/home/$USERNAME/.profile`
	- `/home/$USERNAME/.bash_profile`
	- `/home/$USERNAME/.bashrc`
	- `/home/$USERNAME/.bash_login`
	- `/home/$USERNAME/.bash_logout`
	- `/home/$USERNAME/.zshrc`

---

## Shell Profile Execution Scenarios & Order

### Interactive Login Shell

When logging in as `$USERNAME` (i.e., via SSH or physical access), profiles execute according to the following logic:

- If `bash` is the default shell:
	- If `/home/$USERNAME/.bash_profile` exists:
		- Execute `/etc/.profile`
		- Execute `/home/$USERNAME/.bash_profile`
	- Else:
		- Execute `/etc/.profile`
		- Execute `/home/$USERNAME/.bashrc`
		- Execute `/home/$USERNAME/.profile`
- Else if `zsh` is the default shell:
	- Execute `/etc/.profile`
	- Execute `/home/$USERNAME/.zshrc`

### Interactive Non-Login Shell

When starting an interactive shell but not when logging in, like when spinning up a shell (i.e., running `/bin/bash`) or when switching users (via [[su]]), profiles execute according to the following logic:

- Inherit the environment of the parent shell
- If `bash` is the default shell:
	- Execute `/home/$USERNAME/.bashrc`
- If `zsh` is the default shell:
	- Execute `/home/$USERNAME/.zshrc`

### Non-Interactive Shell

When a shell script is invoked. In this scenario, it operates using the environment inherited from the parent shell only.

### Logging Out of an Interactive Shell

When logging out of an interactive `bash` shell, `/home/$USERNAME/.bash_logout` is executed. There is no equivalent for `zsh`.

---

## References

[tecmint - Understanding Shell Initialization Files & User Profiles in Linux](https://www.tecmint.com/understanding-shell-initialization-files-and-user-profiles-linux/)
