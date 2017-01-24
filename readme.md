# ngrok scripts

## Use Docker image run ngrokd (requirement docker)

create docker container name `ngrokd`
```sh
make docker-create
```

start docker container
```sh
make docker-start
```

run docker container with interactive
```sh
make docker-run
```

stop docker container
```sh
make docker-stop
```

## Compile and run ngrokd (requirement golang)

bulid ngrokd
```sh
make build
```

run ngrokd
```sh
make run
```

## Other commands

create tls
```sh
make tls
```

recreate tls
```sh
make new-tls
```

## Using existing `rootCA.key` and `server.key`

copy `rootCA.key` `server.key` to tls directory and executing above commands
