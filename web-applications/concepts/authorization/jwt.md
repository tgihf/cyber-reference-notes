# [JSON Web Token (JWT)](https://jwt.io/)

> JSON Web Tokens are an open, industry standard [RFC 7519](https://tools.ietf.org/html/rfc7519) method for representing claims securely between two parties.

## Overview

In a web application, server-side session management has its drawbacks, namely that session tokens must be constantly checked against storage to ensure they are still authorized.

JWTs provide a solution to the session-management and authorization problem. The server generates and signs a JWT via a shared secret or public/private key pair and then issues the JWT to the client. The client attaches the JWT to each request, typically as a cookie. When the server recieves a request with a JWT, instead of having to query the database to make sure its still authorized (like in the old way), the server merely has to ensure that the digital signature is still valid. If it is, the server can trust that (1) the server issued the JWT and (2) the JWT hasn't be modified in any way. If it is not, the server can reject the JWT.

The keys to the security of the JWT are (1) the secrecy and strength of the secret and (2) the signature algorithm implementation.

---

## Format
A JSON Web Token (JWT) is an ASCII string comprised of three base64-encoded JSON objects: a header, payload, and signature.

```txt
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
```

### Header

A JWT's Header contains information that identifies which algorithm was used to generate the signature. For example,

```json
{
  "alg": "HS256",
  "typ": "JWT"
}
```

Typical cryptographic algorithms used are HMAC with SHA-256 (HS256) or RSA (RS256), though RFC 7518 describes many more that can be used.

### Payload

A JWT's Payload contains a set of claims. This often includes user or session information which is used by the front end to render elements to the user.

```json
{
  "user": {
  	id: 0,
	username: "admin"
  },
  "iat": 1422779638,
  "exp": 1422780000
}
```

Many JWT payloads contain standard fields as well, such as `iat` and `exp`. `iat` is a timestamp of when the JWT was issued and `exp` is a timestamp of when the JWT will expire.

### Signature

A JWT's signature securely validates the token. The signature is calculated by encoding the header and payload using [Base64url Encoding](https://en.wikipedia.org/wiki/Base64#The_URL_applications "Base64") [RFC](https://en.wikipedia.org/wiki/RFC_(identifier)) [4648](https://datatracker.ietf.org/doc/html/rfc4648) and concatenating the two together with a period separator. That string is then run through the cryptographic algorithm specified in the header, in this case HMAC-SHA256. The _Base64url Encoding_ is similar to [base64](https://en.wikipedia.org/wiki/Base64 "Base64"), but uses different non-alphanumeric characters and omits padding ([Wiki](https://en.wikipedia.org/wiki/JSON_Web_Token)).

```txt
HMAC_SHA256(
  secret,
  base64urlEncoding(header) + '.' +
  base64urlEncoding(payload)
)
```

---

## Brute Forcing a JWT Secret's

[[brute-forcing/techniques/jwt]]

---

## Bypassing Asymmetrically Signed JWTs

Reference: [auth0 - Critical vulnerabilities in JSOB Web Token libraries](https://auth0.com/blog/critical-vulnerabilities-in-json-web-token-libraries/)

Example: [HTB Under Construction](https://github.com/tgihf/private-writeups/blob/main/htb/challenges/under-construction/under-construction.md)

Most JWT libraries' token decode function has a signature like this:

```python
decode(token: str, secret: str, algorithms: List[str])
```

where `token` is the JWT to verify and decode, `secret` is the secret key (in a symmetric system) or public key (in an asymmetric system) used to verify and decode the JWT, and `algorithms` is a list of algorithms the function will attempt to use to verify and decode the `token` with `secret`.

If a web application uses an asymmetric algorithm to sign and verify JWTs, its `decode()` function call needs to specify only the *asymmetric* algorithm(s) it will check for.

If its `decode()` function call specifies any symmetric algorithms in `algorithms`, it is possible for an attacker to forge a JWT signed by the public key (since it is publicly known) under the specified symmetric algorithm. When this `token` and `secret` (the public key) are passed into `decode()`, it will successfully verify and decode it under the specified symmetric algorithm. This allows a forged JWT through, completely circumventing the authenticating and authorization process and compromising the security of the entire application.

---

## References

[auth0 - Critical vulnerabilities in JSOB Web Token libraries](https://auth0.com/blog/critical-vulnerabilities-in-json-web-token-libraries/)
