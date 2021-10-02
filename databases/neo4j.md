# [neo4j](https://neo4j.com/)

> A graph database management system.

---

## Run via Docker

Link [here](https://neo4j.com/developer/docker-run-neo4j/).

### Ensure `neo4j` directories are in place.

```bash
$ mkdir -p ~/.neo4j/data
$ mkdir -p ~/.neo4j/logs
$ mkdir -p ~/.neo4j/import
$ mkdkir -p ~/.neo4j/plugins
```

### Run the Docker Container

```bash
$ docker run -it \
	--name neo4j \
	-p7474:7474 -p7687:7687 \
	-d \
	-v $HOME/.neo4j/data:/data \
	-v $HOME/.neo4j/logs:/logs \
	-v $HOME/.neo4j/import:/var/lib/neo4j/import \
	-v $HOME/.neo4j/plugins:/plugins \
	--env NEO4J_AUTH=neo4j/$PASSWORD \
	neo4j:latest
```

Credentials are `neo4j:$PASSWORD`.
