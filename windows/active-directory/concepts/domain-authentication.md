# Domain Authentication

The most important, and vulnerable, aspect of Active Directory.

## Two Main Types of Authentication in Active Directory

1. Kerberos
    * The **default** authentication service for Active Directory
    * Uses **ticket-granting tickets (TGTs)** and **service tickets** to authenticate users and give access to other resources across the domain
2. NTLM
    * Default Windows authentication mechanism
    * Uses an encrypted challenge/response protocol
