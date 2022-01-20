# ELF File Source

The following `C` source code will run `$COMMAND`.

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
	setuid(0);
	setgid(0);
    system("$COMMAND");
}
```

Compile the source with:

```bash
gcc source.c -o $OUTPUT_FILE
```
