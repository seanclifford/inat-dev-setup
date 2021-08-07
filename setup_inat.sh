#!/usr/bin/env bash

cd ../inaturalist

#set the example as the real override with replacements
cat docker-compose.override.yml.example | sed 's/\${USERNAME}/'$USER'/' | sed 's/\${PASSWORD}/'$USER'/' > docker-compose.override.yml

#Make sure we use the same username/password for the API db user
cat ../iNaturalistAPI/docker-compose.override.yml.example | sed 's/username/'$USER'/' | sed 's/password/'$USER'/' > ../iNaturalistAPI/docker-compose.override.yml

cat ../iNaturalistAPI/config_example.js | sed 's/"username"/"'$USER'"/' | sed 's/"password"/"'$USER'"/' > ../iNaturalistAPI/config.js

#Run the makefile to setup docker services
make services

#Set elasticsearch size limits to be very small for dev
curl -XPUT 'localhost:9200/_cluster/settings' -H "Content-Type: application/json" -d '
{
  "transient": {
    "cluster.routing.allocation.disk.watermark.low": "2gb",
    "cluster.routing.allocation.disk.watermark.high": "100mb",
    "cluster.routing.allocation.disk.watermark.flood_stage": "50mb",
    "cluster.info.update.interval": "1m"
  }
}'

#Ensure elasticsearch has not fallen into readonly already
curl -XPUT 'localhost:9200/_all/_settings' -H "Content-Type: application/json" -d '
{
    "index" : {
        "blocks" : {
          "read_only_allow_delete": false
        }
    }
}'

#copy over elasticsearch files into inaturalist folder (or setting up indexes won't work). TODO: check all this is required...
mkdir elasticsearch
sudo docker cp es:/usr/share/elasticsearch/bin/. elasticsearch/bin
sudo docker cp es:/usr/share/elasticsearch/config/. elasticsearch/config
sudo docker cp es:/usr/share/elasticsearch/jdk/. elasticsearch/jdk
sudo docker cp es:/usr/share/elasticsearch/lib/. elasticsearch/lib
sudo docker cp es:/usr/share/elasticsearch/modules/. elasticsearch/modules
sudo docker cp es:/usr/share/elasticsearch/plugins/. elasticsearch/plugins
sudo chown -R $USER: elasticsearch

nvm use

gem install bundler
bundle install

# Set up your gems, config files, and database
ruby bin/setup

#install node packages
npm install

#build ReactJS code
./node_modules/.bin/gulp webpack

#make sure rails command is availalble
rbenv rehash

#Setup elasticsearch indexes
rake es:rebuild