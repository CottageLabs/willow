#!/bin/bash

cd /willow 

echo Creating tmp
mkdir -p tmp/pids

echo Migrating data...
bundle exec rake db:migrate
echo Starting up

bundle exec rails server -p 3000 -b '0.0.0.0'