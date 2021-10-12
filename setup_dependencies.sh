#!/usr/bin/env bash

if ! command apt-cache search postgresql-client-12 | grep -qc 'postgresql-client-12'; then
    echo "setting up postgres apt source"
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | sudo tee  /etc/apt/sources.list.d/pgdg.list
    sudo apt-get update
fi

echo "installing some dev dependencies..."
sudo apt-get install -y \
    gcc \
    build-essential \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    libcurl4-openssl-dev \
    libpq-dev \
    libgeos-dev \
    libgeos++-dev \
    libproj-dev \
    postgresql-client-common \
    postgresql-client-12 \
    imagemagick \
    libimage-exiftool-perl

. pull_down_inaturalist_repo.sh

. install_nodejs.sh

. install_ruby.sh

sudo bash install_docker.sh

. postgres_setup.sh

# Optional
#sudo bash install_tools.sh


echo "You will need to logout and log back in before running the next script."