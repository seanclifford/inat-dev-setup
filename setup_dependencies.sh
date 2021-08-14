#!/usr/bin/env bash

echo "installing some dev dependencies..."
sudo apt-get install -y \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    libcurl4-openssl-dev \
    libpq-dev libgeos-dev \
    libgeos++-dev \
    libproj-dev \
    postgresql-client-common \
    postgresql-client-12 \
    imagemagick

. pull_down_inaturalist_repo.sh

. install_nodejs.sh

. install_ruby.sh

sudo bash install_docker.sh

. postgres_setup.sh

# Optional
#sudo bash install_tools.sh


echo "You will need to logout and log back in before running the next script."