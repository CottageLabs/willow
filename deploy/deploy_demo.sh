#!/bin/bash
cd /home/willow/willow
git checkout master
git pull --recurse-submodules
ln -sf ../envfile .env
docker-compose down --remove-orphans && docker-compose build && docker-compose up -d
