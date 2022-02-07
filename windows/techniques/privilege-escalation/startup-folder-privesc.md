# Startup Folder Privilege Escalation

---

## Process

- For each [[startup-folders|startup folder]] (users' and the system's):
	- Determine if you have write access to the folder itself or a file in the folder
		- [[icacls#View an Object's DACL|icalcs]]
		- [[accesschk#Determine the Effective Access to a Particular File|accesschk]]
		- [[powershell-acls#View an Object's DACL|powershell]]
	- If you do have write access:
		- Overwrite the file with an arbitrary executable
