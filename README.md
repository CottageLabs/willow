# Willow


## Introduction

[willow](https://github.com/CottageLabs/willow) is an implementation of the Fedora/Hydra stack by [Cottage Labs](http://cottagelabs.com/). It is built with Docker containers, which simplify development and deployment onto live services.


## Getting Started

1. Install Docker [by following step 1 of the Docker Compose installation tutorial](https://docs.docker.com/compose/install/) on your machine.

2. Make sure you don't need to `sudo` to run docker. [Instructions on set-up and how to test that it works.](https://docs.docker.com/engine/installation/linux/ubuntulinux/#/manage-docker-as-a-non-root-user)

3. Install [Docker Compose by following steps 2 and onwards from the Docker Compose installation Tutorial](https://docs.docker.com/compose/install/).

> Ubuntu Linux users, the command that Docker-Compose provides you with will not work since /usr/local/bin is not writeable by anybody but root in default Ubuntu setups. Use `sudo tee` instead, e.g.:
  
```bash
$ curl -L https://github.com/docker/compose/releases/download/[INSERT_DESIRED_DOCKER_COMPOSE_VERSION_HERE]/docker-compose-`uname -s`-`uname -m` | sudo tee /usr/local/bin/docker-compose > /dev/null && sudo chmod a+x /usr/local/bin/docker-compose
```

4. Open a console and try running `docker -h` and `docker-compose -h` to verify they are both accessible.

5. Clone this repository to a suitable place:
```bash
$ cd /some/working/directory
$ git clone https://github.com/CottageLabs/willow.git
$ cd willow
```

6. Create a `.env` file to set the postgres database username and password, and also the Rails session keys; you can use the `example.env` file as a template:

```bash
POSTGRES_USER=postgres
POSTGRES_PASSWORD=password
SECRET_KEY_BASE_DEVELOPMENT=<a very long random hexadecimal number, e.g. 1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef>
SECRET_KEY_BASE_TEST=<a very long random hexadecimal number, e.g. 1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef>
SECRET_KEY_BASE_PRODUCTION=<a very long random hexadecimal number, e.g. 1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef>
WILLOW_EMAIL=<some email address, default is "admin@willow">
WILLOW_PASSWORD=<some password, default is "password">
WILLOW_NAME=<some name, default is "Willow Admin">
```

If running in a production environment and wish to serve Willow on port 80, then you should also set:
```bash
WILLOW_EXPOSED_PORT=80
RAILS_ENV=production
RACK_ENV=production
RAILS_SERVE_STATIC_FILES=true
```

Finally, for development purposes you will probably want to ensure the system is seeded and also running a local version of the willow_sword gem:
```bash
# use local willow_sword submodule during development, rather than gem in github; set to false to disable
LOCAL_WILLOW_SWORD=true

# Seed willow data by default; set to false to disable
WILLOW_SEED=true
```
  
7. Initiate the Geoblacklight and willow_sword submodules

```bash
$ git submodule update --init --recursive
```

8. Run docker-compose to build, and download and initialise the infrastructure

```bash
$ docker-compose down && docker-compose build && docker-compose up 
```

And to completely wipe the system and data, and start from a blank slate:
```bash
$ docker-compose down --volumes && docker-compose build && docker-compose up 
```

  
9. If everything is successful, after a few minutes you should be able to see Fedora Commons running.
  - Mac: `http://<docker_machine_ip>:8080/` (e.g. http://192.168.99.100:8080/)
  - Linux: http://localhost:8080/
  
![Fedora Commons screenshot](docs/images/fedora.png "Fedora Commons screenshot")
  
10. You should also be able to see the Willow and Geoblacklight installations:
  - Willow:
    - Mac: http://192.168.99.100:3000
    - Linux: http://localhost:3000

  ![Willow screenshot](docs/images/willow.png "Willow screenshot")
  
  - Geoblacklight:
    - Mac: http://192.168.99.100:3010
    - Linux: http://localhost:3010
    
    
