# [Kerberos](https://book.hacktricks.xyz/windows/active-directory-methodology/kerberos-authentication)

---

## What is Kerberos?

Kerberos is the primary authentication protocol in an Active Directory environment.

Kerberos is **not** an authorization protocol. While Kerberos provides information about each user's privileges, it is up to each service to enforce those privileges.

---

## Kerberos Actors

There are three actors in a Kerberos system.

1. The **client** who requests access to a resource
2. The **application server (AS)** offers the service/resource being requested by the client
3. The **Key Distribution Center (KDC)** hosts the **Authentication Service (AS)** who issues ticket granting tickets (TGTs) and the **Ticket Granting Service (TGS)** who issues service tickets

---

## Kerberos High Level Authentication Flow

### Client obtains TGT from KDC

`Client` ---[`KRB_AS_REQ`]-->`KDC (AS)`
`Client`<--[`KRB_AS_REP`]---`KDC (AS)`

### Client uses TGT to obtain service ticket from KDC

`Client`---[`KRB_TGS_REQ`]-->`KDC (TGS)`
`Client`<--[`KRB_TGS_REP`]---`KDC (TGS)`

#### Client uses service ticket to access service

`Client`---[`KRB_AP_REQ`]-->`Service`

---

## Kerberos Low Level Authentication Flow

### 1. Client requests a ticket granting ticket (TGT) from the KDC (AS)

![[Pasted image 20211026133654.png]]

The `KRB_AS_REQ` request consists of the following fields:

- A timestamp encrypted with the client's NTLM hash (if [[kerberos#Kerberos Pre-Authentication|Kerberos pre-authentication]] is required)
- The username of the client
- The [[service-principal-name#Service Principal Name https docs microsoft com en-us windows win32 ad service-principal-names|Service Principal Name (SPN)]] associated with the `krbtgt` account
- A nonce generated by the user


### 2. KDC (AS) grants the client a TGT

After receving the `KRB_AS_REQ` request, the KDC confirms the client's claim by decrypting the encrypted timestamp with the client's NTLM hash (the KDC has access to all users' NTLM hashes). It then responds with a `KRB_AS_REP` message.

![[Pasted image 20211026134757.png]]

The `KRB_AS_REP` message contains the following fields:

- The client's username
- The TGT that is encrypted with `krbtgt`'s NTLM hash and consists of the following fields:
	- Client's username
	- Session key
	- TGT expiration time
	- PAC (signed by `krbtgt`)
- The following data structure encrypted with the client's NTLM hash
	- Session key
	- TGT expiration time
	- The same nonce from the `KRB_AS_REQ` request

### 3. Client requests a service ticket from the KDC (TGS)

After receving the `KRB_AS_REP` message from the KDC, the client has all the information necessary to request a service ticket.

![[Pasted image 20211026140012.png]]

The `KRB_AS_REQ` message consists of the following fields:

- Encrypted with the session key:
	- Client's username
	- Timestamp
- TGT (encrypted with `krbtgt`'s NTLM hash)
- [[service-principal-name#Service Principal Name https docs microsoft com en-us windows win32 ad service-principal-names|SPN]] of the desired service
- Nonce generated by the user


### 4. KDC (TGS) grants the client a service ticket

![[Pasted image 20211026141104.png]]

The `KRB_TGS_REP` message consists of the following fields:

- Client's username
- The service ticket encrypted with the service owner's NTLM hash and consisting of the following fields:
	- Service session key
	- Client's username
	- Service ticket expiration timestamp
	- PAC (signed with `krbtgt`'s NTLM hash)
- Encrypted with the session key:
	- Service session key
	- Service ticket expiration timestamp
	- The same nonce from the `KRB_TGS_REQ` request

### 5. Client uses service ticket to access application service

![[Pasted image 20211026141524.png]]

The `KRB_AP_REQ` consists of the following fields:

- Service ticket
- Encrypted with the service session key:
	- Client's username
	- Timestamp

---

## Kerberos Pre-Authentication

Pre-authentication is a Kerberos security mechanism designed to prevent [[offline-password-cracking|offline password cracking attacks]].

When enabled on a particular user's account, the KDC requires the client to include a timestamp encrypted with the client's NTLM hash in the `KRB_AS_REQ` request. If the NTLM hash is correct, the KDC returns a `KRB_AS_REP` message (includes a block of data encrypted with the user's NTLM hash and a TGT encrypted with `krbtgt`'s NTLM hash).

When disabled on a particular user's account, the client doesn't have to include the encrypted timestamp in the `KRB_AS_REQ` request and the KDC will return a `KRB_AS_REP` a `KRB_AS_REP` message (includes a block of data encrypted with the user's NTLM hash and a TGT encrypted with `krbtgt`'s NTLM hash) no matter what.

---

## Privilege Attribute Certificate (PAC)

A data structure within each Kerberos ticket that describes a user's privileges, signed with the KDC's key.

If a service wants to ensure that a user actually has a particular privilege advertised by the user's PAC, they can pass the PAC to the KDC for verification. However, the KDC will only verify that the PAC's signature is correct--it won't check to ensure the user actually has those privileges. Thus, if a malicious user is able to obtain the KDC's key (`krbtgt`), they can generate and legitimately sign an arbitrary PAC, giving them access across the domain.

---

## Kerberos Attacks

### [[ASREP-roasting|AS-REP Roasting]]

### [[kerberoasting|Kerberoasting]]

### [[golden-ticket|Golden Ticket]]

### [[silver-ticket|Silver Ticket]]

### [[unconstrained-delegation|Unconstrained Delegation Attack]]

### [[constrained-delegation|Constrained Delegation Attack]]

### [[resource-based-constrained-delegation|Resource-Based Constrained Delegation Attack]]