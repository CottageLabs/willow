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

6. Initiate the Geoblacklight and willow_sword submodules

```bash
$ git submodule update --init --recursive
```

7. Create four environmental variable files: `.env`, `.env.production`, `.env.development` and `.env.willow.hosting`,  to set the postgres database username and password and also other keys. You can use the `example.env`, `example.env.production`, `example.env.development` and `example.env.willow.hosting` files as templates:

__example .env file__
```bash
POSTGRES_USER=postgres
POSTGRES_PASSWORD=password

# this should be a very long random key. You can use "$ bundle exec rake secret" to generate one.
SECRET_KEY_BASE_TEST=fb350a4ff22efffba83ff0d73e6a73b0bbca9cdb22683c61e49d8f57280a3988e8c79323c48382a0c565b3db1d7f8bf0924d27542c3322db898948f50530879e


# ------------ OPTIONAL PARAMETERS BELOW HERE -------------

WILLOW_EMAIL=<some email address, default is "admin@willow">
WILLOW_PASSWORD=<some password, default is "password">
WILLOW_NAME=<some name, default is "Willow Admin">

# Serve Willow on port 80 (default is 3000)
WILLOW_EXPOSED_PORT=80

# Serve Geoblacklight on port 81 (default is 3010)
GEOBLACKLIGHT_EXPOSED_PORT=81
```

__example .env.production file__
```bash
# this should be a very long random key. You can use "$ bundle exec rake secret" to generate one.
SECRET_KEY_BASE_PRODUCTION=

# Do not seed Willow data
WILLOW_SEED=false

# Do not seed Geoblacklight data
GEOBLACKLIGHT_SEED=false

# Serve static assets
RAILS_SERVE_STATIC_FILES=true
```

__example .env.development file__
```bash
# this should be a very long random key. You can use "$ bundle exec rake secret" to generate one.
SECRET_KEY_BASE_DEVELOPMENT=17fc18b3926912d145c29687e324cc351ab3ac7482487e393d9dfccb4bbaea2dc9960dc2d4a154052832971602af315eb79cbb1b9879b5861a102c3bf9f32a2f

# Set to true to seed Willow data
WILLOW_SEED=true

# Set to true to seed Geoblacklight data
GEOBLACKLIGHT_SEED=true
```
  
__example .env.willow.hosting file__
```bash
# the hostname where Willow will be served from, e.g. willow.cottagelabs.com or localhost
VIRTUAL_HOST: 'willow.local, localhost, willow.cottagelabs.com, 192.168.99.*'
# For internet-visible production instances, an SSL certificate will be obtained from LetsEncrypt with the following settings:
LETSENCRYPT_HOST=willow.cottagelabs.com
LETSENCRYPT_EMAIL=someone@example.com
LETSENCRYPT_TEST='true'
```
  

8. Run `docker-compose up` to download, build and initialise the infrastructure

The system can be built and run in either *development* mode (allowing changes on the fly) or in *production* mode (where code and assets are pre-built and cannot be changed on startup).
 
To enable development mode, you should symlink the file `docker-compose.development.yml` to `docker-compose.override.yml`.
Conversely, to enable production mode, simply delete the `docker-compose.override.yml` file if it exists.

__enabling development mode__
```bash
$ ln -sf docker-compose.development.yml docker-compose.override.yml
```

__enabling production mode__
```bash
$ rm -f docker-compose.override.yml
```

To build and run the system, issue the `up` command to docker-compose: 
```bash
$ docker-compose up --build
```

Note that once the system has been built, the image will be cached. You can force a rebuild with `docker-compose up --build`.


And to start from a blank slate by completely wiping the system and data, run `docker-compose down --volumes` first:
```bash
$ docker-compose down --volumes && docker-compose up --build 
```


9. If everything is successful, after a few minutes you should be able to see Willow running.
  - Willow:
    - Mac: http://192.168.99.100:3000 (or possibly port 80 depending on your `env` files)
    - Linux: http://localhost:3000

  ![Willow screenshot](docs/images/willow.png "Willow screenshot")
  
  - Geoblacklight:
    - Mac: http://192.168.99.100:3010
    - Linux: http://localhost:3010
    
    
10. To get a bash prompt within the Willow container (e.g. to run rake tasks), you can run:
```bash
$ docker-compose run willow bash
```