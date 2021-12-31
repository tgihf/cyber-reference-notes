# Active Directory Certificate Services (ADCS)

---

## Certificate Request & Generation Process

1. Client generates a public and private key pair
2. Client creates a certificate signing request (CSR) with their public key, the subject of the request, and the Active Directory certificate template to be used to generate the certificate
3. Client sends the CSR to the domain's Enterpise Certificate Authority (CA), who is responsible for generating certificates
4. Enterprise CA checks several things, including:
	- Is the authenticating client allowed to enroll for a certificate?
	- Does the specified certificate template Active Directory object exist?
	- Are the settings in the CSR allowed by the certificate template?
5. If everything checks out, Enterprise CA generates the certificate with information from the certificate template and from the CSR and signs the certificate with its private key and returns it to the client
6. Client stores the certificate in Windows Certificate Store and uses it to perform actions allowed by the certificate

---

## References

[Certified Pre-Owned Whitepaper by Specter Ops](https://www.specterops.io/assets/resources/Certified_Pre-Owned.pdf)

[Certified Pre-Owned Blog Post by Specter Ops](https://posts.specterops.io/certified-pre-owned-d95910965cd2)
