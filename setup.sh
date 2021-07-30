#!/usr/bin/env bash

. pull_down_inaturalist_repo.sh

echo installing some dev dependencies...
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev libcurl4-openssl-dev libpq-dev

#echo installing iNaturalist dependencies
#sudo apt-get install -y imagemagick redis memcached postgis

#echo attempting to start PostgreSQL
#sudo systemctl start postgresql@12-main

. install_nodejs.sh

. install_ruby.sh

. install_docker.sh

. postgres_setup.sh

echo "You will need to logout and log back in before running the next script."