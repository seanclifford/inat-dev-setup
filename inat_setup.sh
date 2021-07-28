#!/usr/bin/env bash

cd ../inaturalist

#create docker .env file for username/password
echo "USERNAME=$USER
PASSWORD=$USER" > .env

#set the example as the real override (should use the env variables above)
cp docker-compose.override.yml.example docker-compose.override.yml

#Make sure we use the same username/password for the API db user
cat ../iNaturalistAPI/docker-compose.override.yml.example | sed 's/username/'$USER'/' | sed 's/password/'$USER'/' > ../iNaturalistAPI/docker-compose.override.yml

cat ../iNaturalistAPI/config_example.js | sed 's/"username"/"'$USER'"/' | sed 's/"password"/"'$USER'"/' > ../iNaturalistAPI/config.js

#Run the makefile to setup docker services
make services

nvm use

# Set up your gems, config files, and database
ruby bin/setup

# Watch the output for errors! In particular, make sure the database gets
# created correctly. If it doesn't check the settings in config/database.yml
# Note that you will need to fill out some of the config YML files in config/ to
# get absolutely everything working, especially third party services.

#Setup iNaturalistAPI with docker (have to get database setup first by bin/setup)
make services-api