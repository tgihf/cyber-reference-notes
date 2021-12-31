# Windows Persistence

References:

- [ired.team Windows Persistence](https://www.ired.team/offensive-security/persistence)

---

## [[run-keys|Registry Run Keys]]

---

## [[autologon|AutoLogon]]

---

## Startup Folders

The user startup folder path is `C:\Users\$USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`. Whenever `$USERNAME` logs in, all executables in this folder will be executed.

The system startup folder path is `C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp`. Whenever **any** user logs in, all executables in this folder will be executed.

References:

- [MITRE ATT&CK](https://attack.mitre.org/techniques/T1547/001/)

---

## Create an Account

`cmd`
- [[windows/tools/cmd/cmd#Create a new local user|Create a new local user]]
- [[cmd-active-directory#Create a new domain user|Create a new domain user]]

References:

- [ired.team Windows Persistence -> Create User Account](https://www.ired.team/offensive-security/persistence/t1136-create-account)

---

## Sticky Keys

Sticky Keys is an accessibility feature in Windows that allows a user to press keys in sequence rather than simultaneously. Sticky keys can be activating by pressing the `Shift` key 5 times in a row.

This technique works by replacing the executable that is ran whenever sticky keys are activated, `C:\Windows\System32\sethc.exe`, with the target executable. It may be necessary to also change the owner of `C:\Windows\System32\sethc.exe` to yourself.

Once the swap has been made, press the `Shift` key 5 times in a row at the login prompt to execute the payload.

References:

- [ired.team's Windows Persistence -> Sticky Keys](https://www.ired.team/offensive-security/persistence/t1015-sethc)
- [University of Illinois at Urbana-Champaign Article](https://www.disability.illinois.edu/academic-support/assistive-technology/windows-7-sticky-keys)

---

## Scheduled Tasks

A Windows scheduled task will execute an arbitrary program at the specified time interval. By scheduling a task that runs an implant executable, persistent access can be achieved.

[[schtasks|schtasks.exe]]

References:
- [ired.team Windows Persistence -> Scheduled Tasks](https://www.ired.team/offensive-security/persistence/t1053-schtask)

---

## Services

Windows services will execute an arbitrary program regularly just like scheduled tasks--however, Windows services offers much more granular control over the trigger of the program. By configuring a service that runs an implant executable, persistent access can be achieved.

[[sc|sc.exe]]

References:
- [ired.team's Windows Persistence -> Service Execution](https://www.ired.team/offensive-security/persistence/t1035-service-execution)

---

## DLL Search Order Hijacking

The technique of placing a malicious DLL before a legitimate DLL in the search order that Windows uses to retrieve a DLL when one of its functions is called. The search order is specified in the `PATH` environment variable.

References:

- [Microsoft's Documentation on the DLL Search Order](https://docs.microsoft.com/en-us/windows/win32/dlls/dynamic-link-library-search-order)
- [MITRE ATT&CK](https://attack.mitre.org/techniques/T1574/001/)

---

## DLL Proxying

A DLL hijacking technique that replaces a legitimate DLL with a DLL that first executes a malicious payload and then forwards the function call to the legitimate DLL.

A thorough writeup can be found at [ired.team's Windows Persistence -> DLL Proxying blog](https://www.ired.team/offensive-security/persistence/dll-proxying-for-persistence). A PowerShell script that retrieves the exported functions from a legitimate DLL and creates a malicious proxy DLL source code template can be found at [this repo](https://github.com/Flangvik/SharpDllProxy).
