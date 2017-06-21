#!/bin/bash
cd /home/willow/willow
git checkout master
git pull --recurse-submodules
git submodule update --recursive --init
ln -sf ../env.general .env
ln -sf ../env.production .env.production
ln -sf ../env.development .env.development
ln -sf ../env.willow.hosting .env.willow.hosting
rm -f docker-compose.override.yml
docker-compose down --remove-orphans && docker-compose build && docker-compose up -d
