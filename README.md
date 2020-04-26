# Simple grafana + prometheus lab repository

> Disclaimer: This is not intended for production use, is only a repository to run experiments with Prometheus and Grafana

A simple repository lab to test (This readme is WIP)

## Requirements to run this test

- Docker
- Docker compose

### Optional

- NodeJS (Only if you want to run the backend locally)
- Golang (Oonly if you want to install bombardier via `go get`)

## To load test the backend application

I used bombardier to load test the backend app

- Github repo https://github.com/codesenberg/bombardier
- Releases https://github.com/codesenberg/bombardier/releases

### Usage example

> Before you start consider that this lab requires the following ports available
>
> - 9090
> - 3000
> - 4000

1. Start the lab environment by running

```
make up
```

If you started the enviornment with this command to stop it use

```
make stop
```


Or start it attached and with log outputs (Either one of both)

```
make up-logs
```

If you started the environment with this command, stop it with `Ctrl + c`

To delete everything and clean completelly the environment 
(this would also delete the metrics collected by prometheus)

```
make down
```

> After running docker compose you can check that all the containers are running with `docker ps`, you can also visit http://localhost:4000/metrics, http://localhost:3000/ and http://localhost:9090/metrics to verify that everything is running correctly, grafana default admin and password are: user: `admin`, password: `admin`

2. Create a new board and load the configuration under the section `Board JSON` of this readme, once the board is created you can start sending traffic to the backend application, some examples below

```bash
bombardier -c 200 -n 10000 http://localhost:4000/status
```

```bash
bombardier -c 200 -n 10000 http://localhost:4000/hello
```

## Versions

### NodeJS

Install this only if you want to run the backend outside the container, everything in this lab runs within docker, you don't need to have anything else than docker installed

(Prefer [nvm](https://github.com/nvm-sh/nvm))

```
v10.19.0
```

### Docker

```
Client: Docker Engine - Community
 Version:           19.03.8
 API version:       1.40
 Go version:        go1.12.17
 Git commit:        afacb8b
 Built:             Wed Mar 11 01:21:11 2020
 OS/Arch:           darwin/amd64
 Experimental:      false
```

### Docker compose

```
docker-compose version 1.25.4, build 8d51620a
```

## Golang version

If you want to intall bomqbardier using go get

```
go version go1.13.5 darwin/amd64
```

## Boards

- You can export boards using the grafana API to extract the JSON configuration of the board and the `make up` or the
`make up-logs` commands will import any board that you export and meets the criteria below, you only have to
  - Put your json file under boards/import/ with as a `.json` file with valid json syntax
  - Make sure that the board `id` and `uid` fields are set to null, you can look at the example board under import called backend.json

## DONE

- [x] Add the grafana boards as code
    - [x] Also they are imported now automatically
- ~~Explain how to configure grafana~~ (Unnecessary, this project configures itself now)

## TODO


- [ ] Make ports for everything configurable
- [x] ~~Explain how to create the boards~~ (Changed to have a convention on how to load boards)