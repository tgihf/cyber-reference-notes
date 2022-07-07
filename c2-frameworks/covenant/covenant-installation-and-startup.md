# [Installing & Starting Covenant](https://github.com/cobbr/Covenant/wiki/Installation-And-Startup)

---

## Docker

### Build the Docker Image

```bash
git clone --recurse-submodules https://github.com/cobbr/Covenant
cd Covenant/Covenant
docker build -t covenant .
```

### Start the Docker Container

```bash
docker run -it -p 7443:7443 -p 80:80 -p 443:443 --name covenant -v $COVENANT_DATA_DIRECTORY:/app/Data covenant
```

- `$COVENANT_DATA_DIRECTORY`
	- Absolute path to `Covenant/Covenant/Data`

---

## Setup an HTTPS Listener with Legitimate TLS Certificate

1. Generate a [[tls-certificates#Generate a Legitimate TLS Certificate for a Standalone Web Server from LetsEncrypt https letsencrypt org|legitimate TLS certificate]] or a [[tls-certificates#Generate a Self-Signed TLS Certificate|self-signed TLS certificate]].

2. [[tls-certificates#Translate a PEM Certificate into a PFX Certificate|Translate that certificate into PFX format]].

3. Create a new HTTP listener with the following settings:

![[Pasted image 20211027104905.png]]

Name it whatever you want.

In this example, `ConnectAddresses` is the domain name that points to the Covenant server. Ideally, this should be the domain names that point to your redirectors.

Make sure that `UseSSL` is `true` and select `certificate.pfx` for `SSLCertificate`. Enter the password you chose when generated the certificate for `SSLCertificatePassword`.

---

## Test an HTTPS Listener

To easily test an HTTPS listener, in the Covenant web interface, navigate to `Listeners` > `Hosted Files`. Host an arbitrary file.

Attempt to download the file via HTTPS.

```bash
curl https://$DOMAIN/$FILE
```

If the download succeeds, the listener is good to go.
