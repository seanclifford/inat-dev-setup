#!/usr/bin/env bash

cd ../inaturalist

#create docker .env file for username/password
echo "USERNAME=$USER
PASSWORD=$USER" > .env

#Set Postgres default username password to use
echo "*:*:*:$USER:$USER" > ~/.pgpass
chmod u=rw,og= ~/.pgpass

#set the example as the real override (should use the env variables above)
cp docker-compose.override.yml.example docker-compose.override.yml

#Make sure we use the same username/password for the API db user
cat ../iNaturalistAPI/docker-compose.override.yml.example | sed 's/username/'$USER'/' | sed 's/password/'$USER'/' > ../iNaturalistAPI/docker-compose.override.yml

cat ../iNaturalistAPI/config_example.js | sed 's/"username"/"'$USER'"/' | sed 's/"password"/"'$USER'"/' > ../iNaturalistAPI/config.js

#Run the makefile to setup docker services
make services

nvm use

gem install bundler

# Set up your gems, config files, and database
ruby bin/setup

#install node packages
npm install

#build ReactJS code
./node_modules/.bin/gulp webpack

#make sure rails command is availalble
rbenv rehash

#Setup an initial site
rails r "Site.create( name: 'iNaturalist', url: 'http://localhost:3000' )"

#Load some seed data...
# Load source records for citation
rails r tools/load_sources.rb
# Load the basic iconic taxa to get the taxonomy started
rails r tools/load_iconic_taxa.rb
# Generate translation files (optional)
#rake inaturalist:generate_translations_js

# Watch the output for errors! In particular, make sure the database gets
# created correctly. If it doesn't check the settings in config/database.yml
# Note that you will need to fill out some of the config YML files in config/ to
# get absolutely everything working, especially third party services.

#Setup iNaturalistAPI with docker (have to get database setup first by bin/setup)
echo "run: make services-api in a terminal window to run the API"
echo "run: rails s -b 127.0.0.1 in a terminal window to run the inaturalist website (accessable on http://127.0.0.1:3000)"