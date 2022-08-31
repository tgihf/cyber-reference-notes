# Active Directory Certificate Services (ADCS)

An Active Directory service that integrates public key infrastructure (PKI) into an Active Directory environment for the purpose of leverage digital signatures and digital certificates for authentication, S/MIME, secure wireless networking, VPN, IPsec, EFS, smart card logon, and more.

Similar to Active Directory as a whole, ADCS isn't inherently insecure. However, it can be misconfigured into insecurity.

---

## Request a PEM User Certificate

See [[certify#Request a PEM User Certificate|here]].

---

## Request a PEM User Certificate with an Alternate Subject Name

See [[certify#Request PEM User Certificate with Alternate Subject Name|here]].

---

## Request a PEM Machine Certificate

See [[certify#Request a PEM Machine Certificate|here]].

---

## Relay NTLM to ADCS HTTP Enrollment Endpoint for Certificate

Via Cobalt Strike, see [[cobalt-strike-ntlm-relaying#Relaying an NTLM to a ADCS HTTP Endpoint|here]].

---

## Use a Certificate to Authenticate and Obtain a TGT

### 1. Convert PEM certificate into base64 encoded PFX certificate

See [[adcs#Convert a PEM Certificate into a Base64-Encoded PFX Certificate|here]].

### 2. Levergage base64 encoded PFX certificate to request a TGT

See [[rubeus#Request TGT using Base64-Encoded PFX Certificate|here]].

---

## Convert a PEM Certificate into a Base64-Encoded PFX Certificate

A PEM certificate consists of a private key and a certificate, each as base64 blobs between headers and footers, like so:

```txt
-----BEGIN RSA PRIVATE KEY-----
$BASE64_PRIVATE_KEY_HERE
-----END RSA PRIVATE KEY-----
-----BEGIN CERTIFICATE-----
$BASE64_CERTIFICATE_HERE
-----END CERTIFICATE-----
```

Copy **the entire thing**, from the **beginning of the private key header** to the **end of the certificate footer**. Paste it into a file named `cert.pem` on a \*nix machine.

Convert the file into a `.pfx` certificate.

```bash
openssl pkcs12 -in cert.pem -keyex -CSP "Microsoft Enhanced Cryptographic Provider v1.0" -export -out cert.pfx
```

This will prompt you for a password you can use to protect the PFX certificate. Choose whatever.

Convert the `cert.pfx` certificate into a base64 blob.

```bash
cat cert.pfx | base64 -w 0
```

---

## Leveraging a Certificate for Persistence

A certificate is a wonderful domain persistence mechanism for a few reasons:

1. Faroff expiration date by default (1 year)
2. Doesn't change when corresponding principal's password changes
3. Relatively uncommon
4. Only rendered ineffective by expiration or revocation

To leverage a certificate for persistence, analyze the available certificate templates, keeping the following criteria in mind:

- Faroff expiration date
- Doesn't require administrator authorization
- Good for client authentication

Once you've found a suitable certificate template, [[adcs#Request a PEM User Certificate|request it]] (or if it's a template for a machine account, see [[adcs#Request a PEM Machine Certificate|here]]). 

---

## References

[Certified Pre-Owned Blog Post - SpecterOps](https://posts.specterops.io/certified-pre-owned-d95910965cd2?gi=b6fdf9127f84)

[Certified Pre-Owned White Paper - SpecterOps](https://specterops.io/assets/resources/Certified_Pre-Owned.pdf)
