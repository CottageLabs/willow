# clio
> Begin thou, unforgetting Clio, for all the ages are in thy keeping, and all the storied annals of the past.
>
> -- Statius, Thebaid

## Introduction

[clio](https://github.com/CottageLabs/clio) is an implementation of the Fedora/Hydra stack by [Cottage Labs](http://cottagelabs.com/). It is built with Docker containers, which simplify development and deployment onto live services.

## Running on Ubuntu

### Installing docker-compose

Follow Docker-Compose's documentation on installing it on Ubuntu [here](https://docs.docker.com/compose/install/)

### Setting up the environment

Create an `env.sh` file that looks something like this:

```
export POSTGRES_PASSWORD=
export POSTGRES_USERNAME=
```

Ask one of the maintainers of the repo about the values.

Source the environment variables:

```
source env.sh
```

Build the docker containers:

```
sudo -E docker-compose build fedora_commons
sudo -E docker-compose build tomcat
```

Run the tomcat container to get access to the application:

```sudo -E docker-compose up tomcat```

Go to `localhost:8080/fcrepo` to see the application running.



