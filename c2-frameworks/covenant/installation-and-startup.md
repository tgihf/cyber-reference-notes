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
