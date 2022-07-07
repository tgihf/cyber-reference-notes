# Docker

---

## Run Docker Container

```bash
docker -it [-p $HOST_PORT:$CONTAINER_PORT] [-v $PATH_ON_HOST_TO_MOUNT:$PATH_ON_CONTAINER_TO_MOUNT] --name $CUSTOM_NAME_FOR_CONTAINER $IMAGE_NAME
```

---

## Interact with Shell of Running Container

```bash
docker exec $CONTAINER_NAME_OR_ID $SHELL
```

- `$SHELL` could be `bash`, `sh`, or whatever other shell you want that's actual on the container's file system

---

## References

[Docker](https://www.docker.com/)
