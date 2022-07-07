# `AlwaysInstallElevated` Privilege Escalation

`AlwaysInstallElevated` is a feature that ensures `.msi` programs are always installed as `NT AUTHORITY/SYSTEM`.

If the entry `AlwaysInstallElevated` at `HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer` and `HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer` is equal to 1, then the feature is enabled.

---

## Package an Executable into an `.msi` Installer

1. Launch **Visual Studio**
2. Select **Create New Project**
3. Type **installer** into the search box
4. Select **Setup Wizard** and click **Next**
5. Give the project a name
6. Select the **Location**
7. Select **Place solution and project in the same directory**
8. Click **Create**
9. Keep clicking **Next** until you get to step 3 of 4 (choosing files to include)
10. Click **Add** and select the executable you'd like to package up
11. Click **Finish**
12. Highlight the project name in the **Solution Explorer** and in the properties **Properties** table, change **TargetPlatform** from **x86** to **x64** (if necessary)
	- You can also change the program's **Author** and **Manufacturer** to make it seem more legitimate
13. Right-click the project and select **View**  -> **Custom Actions**
14. Right-click **Install** and select **Add Custom Action**
15. Double-click on **Application Folder**, select the executable, and click **OK**
	- This ensures the executable is ran as soon as the installer is ran
16. With the executable highlighted in the **Custom Actions** -> **Install** pane, under the **Custom Action Properties** table in the **Solution Explorer**, change **Run64Bit** to **True** (if necessary)
17. Build the project and grab your `.msi` from the project directory

---

## Install (Run) an `.msi`

```batch
msiexec /i $PATH_TO_MSI /q /n
```

This creates a program in **Programs and Features** and at `C:\Windows\Program Files` (or `C:\Windows\Program Files (x86)` depending on the program's architecture).

---

## Cleaning Up

```batch
msiexec /q /n /uninstall $PATH_TO_MSI
```

- Remove `$PATH_TO_MSI`
- Remove `C:\Windows\Program Files\$PROGRAM` (or `C:\Windows\Program Files (x86)\$PROGRAM` depending on the program's architecture)

---

## Cobalt Strike OPSEC Caveat

When you leverage this technique to execute a Beacon, the Windows Installer process remains running until the Beacon exits. This isn't exactly good OPSEC.

To mitigate this, immediately inject a new Beacon into another process. Then kill the original Beacon and [[always-install-elevated-privesc#Cleaning Up|clean up]].
