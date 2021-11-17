# Domain Controller

A windows server that has **Active Directory Domain Servies (ADDS)** installed and has been promoted to domain controller in the forest. Domain controllers are the center of Active Directory because they control the rest of the domain.

## Tasks of a Domain Controller

* Holds the ADDS data store
* Handles authentication and authorization
* Replicates updates from other domain controllers in the forest for consistency
* Allows admin access to manage domain resources

## Active Directory Domain Services (ADDS) Data Store

Holds the databases and processes required to store and manage directory information such as users, groups, and services. Outline of some of the contents and characteristics of the ADDS Data Store:

* Contains the **Ntds.dit** file -- a database that contains all of the information of an Active Directory domain controller, as well as **password hashes for domain users**.
* Stored by default in **%SystemRoot%\\NTDS**.
* Accessible only by the domain controller.
