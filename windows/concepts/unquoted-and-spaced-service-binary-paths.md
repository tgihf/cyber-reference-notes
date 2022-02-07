# Unquoted & Spaced Service Binary Paths

When a service whose binary path is unquoted and contains spaces is started, Windows attempts to find a file that ends with the target extension **at each space**. If you're capable of writing an arbitrary binary ahead of the legitimate file in the search order, you can have the service execute your binary.

For example, if the target binary is `C:\Program Files\Big Space\blah.exe`, then Windows is going to look in this order:
	- `C:\Program.exe`
	- `C:\Program Files\Big.exe`
	- `C:\Program Files\Big Space\blah.exe`

If you can write `C:\Program.exe` or `C:\Program Files\Big.exe`, Windows will execute your binary instead of `C:\Program Files\Big Space\blah.exe`.
