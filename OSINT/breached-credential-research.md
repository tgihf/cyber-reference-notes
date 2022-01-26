# Breached Credential Research

> Determining if any gathered usernames and/or email addresses have credentials from a known breach dump in order to attempt to reuse those credentials.

---

## Performing Breached Credential Research

### Web Applications

These web applications and their APIs allow you to find credentials, email addresses, usernames, IP addresses, names, addresses, phones, VINs, and domains based on the input. The input can often be one or more of these parameters.

[Scylla](http://www.scylla.sh/) **does not** require a free account and returns good results, but is often down. Definitely try it first.

These applications require a paid account:

- [DeHashed](https://dehashed.com/)
- [We Leak Info](https://weleakinfo.to/)
- [LeakCheck](https://leakcheck.net/)
- [Snusbase](https://leakcheck.net/)

[Have I Been Pwned?](https://haveibeenpwned.com/) doesn't require a paid account, but only returns whether or not the input is present in one of its breaches, not the resultant credential from that breach. This is more for people to check and see if they've been breached so they can know if they need to change their password, but can still be helpful for determining the same about a target.
