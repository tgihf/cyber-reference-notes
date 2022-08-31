# COM Hijacking

> A Windows persistence technique that involves overwriting a [[component-object-model|COM]] component's default registry value to point to an attacker-controlled payload. When the COM component is instantiated by some other process, the attacker-controlled payload is executed.

---

## Methodology

### 1. Determine the COM Component to be Hijacked

As noted [[component-object-model#Registration|here]], if a COM component contains a registry entry in both `HKCU\Classes\` and `HKLM\Classes\`, the one in `HKCU\Classes\` will be used. Notably, the current user can modify or write whatever registry entries they want to `HKCU\Classes\`.

#### Technique #1: Leveraging Scheduled Tasks

1. Determine which scheduled tasks use custom triggers to call COM components.

```powershell
$Tasks = Get-ScheduledTask

foreach ($Task in $Tasks)
{
  if ($Task.Actions.ClassId -ne $null)
  {
    if ($Task.Triggers.Enabled -eq $true)
    {
      if ($Task.Principal.GroupId -eq "Users")
      {
        Write-Host "Task Name: " $_.TaskName
        Write-Host "Task Path: " $_.TaskPath
        Write-Host "CLSID: " $_.Actions.ClassId
        Write-Host "Triggers: " $_.Triggers
      }
    }
  }
}
```

In one line:

```powershell
Get-ScheduledTask | ? { ($_.Actions.ClassId -ne $null) -and ($_.Triggers.Enabled -eq $true) -and ($_.Principal.GroupId -eq "User
s") } | % { "Task Name: $($_.TaskName)`nTask Path: $($_.TaskPath)`nClass ID: $($_.Actions.ClassId)`nTriggers: $($_.Triggers)`n`n" }
```

2. Select which task you'd like to hijack

Since these are executed by the task scheduler, it's easier to predict when they'll execute compared to the COM components discovered in technique #2.

The downside to this  technique over technique #2 is that if the chosen scheduled task legitimately relies on the functionality of the COM component, it will break the scheduled task and have potentially serious ramifications for the system. [DLL proxying](https://www.ired.team/offensive-security/persistence/dll-proxying-for-persistence) could allow you to mitigate this, however.

#### Technique #2: Monitoring for Abandoned Components

Leverage the [SysInternals Suite](https://docs.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite)'s [Process Monitor](https://docs.microsoft.com/en-us/sysinternals/downloads/procmon) to find instances of applications trying to load COM objects that don't actually exist:

1. Launch Process Monitor
2. Add the following filters:
	- `RegOpenKey` operations
	- `Result` is `NAME NOT FOUND`
	- `Path` ends with `InprocServer32`

![[Pasted image 20220609135941.png]]

3. With Process Monitor running, perform various actions on the machine in order to generate events
	- Start programs
	- Launch the Windows menu
	- Click random things

4. Choose a COM component based on:
	- How frequently it's loaded
		- If you hijack a COM component that is loaded every couple of seconds, you're going to generate way too much traffic with the resultant callbacks
		- Choose a component that is loaded semi-frequently, or
		- Choose a component that is loaded when a commonly used application (Word, Excel, etc.) is opened

5. Once you've selected a COM component, note its `CLSID`

### 2. Hijack the COM Component

Does the COM component contain a registry entry in `HKCU`? It'll be at the path `HKCU\Classes\CLSID\{$CLSID}`.

If not, you'll need to create one. [[registry#Interacting with the Registry|Interact with the registry]] to add the following registry values.

| Path | Name | Value |
| --- | --- | --- |
| `HKCU\Classes\CLSID\{$CLSID}` | `InprocServer32` | `$PATH_TO_DLL` |
| `HKCU\Classes\CLSID\{$CLSID}` | `ThreadingModel` | `Both` |

If the COM component does contain a registry entry in `HKCU`, you'll need to modify it. [[registry#Interacting with the Registry|Interact with the registry]] to modify the following registry values.

| Path | Name | Value |
| --- | --- | --- |
| `HKCU\Classes\CLSID\{$CLSID}` | `InprocServer32` | `$PATH_TO_DLL` |
| `HKCU\Classes\CLSID\{$CLSID}` | `ThreadingModel` | `Both` |

Note that according to [[component-object-model#COM Registry Entry Structure|here]], you could substitute `InprocServer32` for `LocalServer32` and a path to an exe instead of a DLL.

---

## References

[[component-object-model|COM]]

[COM Hijacking - Zero-Point Security CRTO Course](https://training.zeropointsecurity.co.uk/courses/take/red-team-ops/texts/30332403-com-hijacking)

[Hunting for COM Hijacks - Zero-Point Security CRTO Course](https://training.zeropointsecurity.co.uk/courses/take/red-team-ops/texts/30332454-hunting-for-com-hijacks)
