#!/bin/bash
cd /home/willow/willow
git checkout master
git pull --recurse-submodules
git submodule update --recursive --init
ln -sf ../envfile .env
docker-compose down --remove-orphans && docker-compose build && docker-compose up -d
