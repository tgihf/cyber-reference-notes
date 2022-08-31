# Data Protection API (DPAPI)

- Application-programmer interface (API) for encrypting and decrypting arbitrary data on behalf of native and third-party Windows applications
- Handles key management by generating one or more **master keys** per user based on their logon password and other data
- Encryption and decryption function calls don't require a key to be specified--DPAPI will intelligently choose the correct key based on the user calling the function 	

---

## References

[Data Protection API - Wikipedia](https://en.wikipedia.org/wiki/Data_Protection_API)

[Operational Guidance for Offensive DPAPI Abuse - SpecterOps](https://posts.specterops.io/operational-guidance-for-offensive-user-dpapi-abuse-1fb7fac8b107)
