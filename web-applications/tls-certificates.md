# TLS Certificates

---

## Generate a Self-Signed TLS Certificate

```bash
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days $NUMBER_OF_DAYS_UNTIL_EXPIRATION
```

This will generate two files:

- `cert.pem`
- `key.pem`

---

## Generate a Legitimate TLS Certificate for a Standalone Web Server from [LetsEncrypt](https://letsencrypt.org/)

To generate a TLS certificate, you need to own the domain you're generating the certificate for. In this example, I own the domain `tgihf.click` and will be generating a certificate for `covenant.tgihf.click`.

1. Install `certbot` on the Web Server

2. Use `certbot` to generate the desired TLS certificates.

```bash
certbot certonly -d $DOMAINS
```

- `$DOMAINS` is either a single domain or a comma separated list of domains, and each should point to the web server

Example:

```bash
certbot certonly -d covenant.tgihf.click
```

Choose to spin up a temporary web server. ACME will do a check to ensure the web server that the domain points to is functional--make sure it is accessible via port 80.

This will generate four files:

- `/etc/letsencrypt/live/$DOMAIN/cert.pem`
- `/etc/letsencrypt/live/$DOMAIN/chain.pem`
- `/etc/letsencrypt/live/$DOMAIN/privkey.pem`
- `/etc/letsencrypt/live/$DOMAIN/fullchain.pem`

---

## Translate a PEM Certificate into a PFX Certificate

```bash
openssl pkcs12 -export -out $OUTFILE.pfx -inkey privkey.pem -in cert.pem [-certfile chain.pem]
```

---

## Decode a Certificate Signing Request

```bash
openssl req -in $PATH_TO_CSR -noout -text
```
