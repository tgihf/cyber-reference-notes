# Empire

> Empire 4 is a post-exploitation framework that includes pure-PowerShell Windows agents, Python 3.x Linux/OS X agents, and C# agents. It is the merger of the previous PowerShell Empire and Python EmPyre projects. The framework offers cryptologically-secure communications and a flexible architecture.

---

## Glossary

- A `Listener` is an endpoint on the Empire server for receiving connections from `Stagers` and `Agents`
- A `Stager` is a payload that, when executed on a target, retrieves an `Agent` from a `Listener` on the Empire Server and executes it on the target
- An `Agent` is a payload that, when staged on a target, repeats a **cycle** of:
	- Checking for queued tasks from a `Listener` on the Empire Server
	- Executing those tasks
	- Sleeping for a specified period of time
	- Returning results from those tasks
- A `Module` is a task that an `Agent` can execute on a target
	- For example, to list a directory, download a file, or run a C# assembly

---

## Installation & Startup

See [[empire-installation-and-startup|here]].

---

## List Listeners

```bash
(Empire) > listeners
```

---

## Start HTTP Listener

```bash
(Empire) > uselistener http
```

Configure the options. Note that the option `Port` is required.

```bash
(Empire: uselistener/http) > options
```

Start it.

```bash
(Empire: uselistener/http) > execute
```

---

## References

[Empire GitHub Repository](https://github.com/BC-SECURITY/Empire)

[Empire Documentation](https://www.bc-security.org/blog)

[BC Security's Blog](https://www.bc-security.org/blog)

