#!/usr/bin/env bash
cd ../../
git checkout master && \
git pull && \
rm docker-compose.override.yml && \
docker-compose build && \
docker tag cottagelabs/willow 835219480274.dkr.ecr.eu-west-2.amazonaws.com/willow:latest && \
docker tag cottagelabs/willow-solr 835219480274.dkr.ecr.eu-west-2.amazonaws.com/willow-solr:latest && \
docker tag cottagelabs/willow-redis 835219480274.dkr.ecr.eu-west-2.amazonaws.com/willow-redis:latest && \
docker tag cottagelabs/willow-fedora 835219480274.dkr.ecr.eu-west-2.amazonaws.com/willow-fedora:latest && \
docker tag cottagelabs/willow-geoblacklight 835219480274.dkr.ecr.eu-west-2.amazonaws.com/willow-geoblacklight:latest && \
docker push 835219480274.dkr.ecr.eu-west-2.amazonaws.com/willow:latest && \
docker push 835219480274.dkr.ecr.eu-west-2.amazonaws.com/willow-solr:latest && \
docker push 835219480274.dkr.ecr.eu-west-2.amazonaws.com/willow-redis:latest && \
docker push 835219480274.dkr.ecr.eu-west-2.amazonaws.com/willow-fedora:latest && \
docker push 835219480274.dkr.ecr.eu-west-2.amazonaws.com/willow-geoblacklight:latest && \
ln -sf docker-compose.development.yml docker-compose.override.yml && \
cd ../../aws
