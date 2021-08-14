#!/usr/bin/env bash

cd ../inaturalist

#set the example as the real override with replacements
cat docker-compose.override.yml.example | sed 's/\${USERNAME}/'$USER'/' | sed 's/\${PASSWORD}/'$USER'/' > docker-compose.override.yml

#Make sure we use the same username/password for the API db user + extra_hosts
cat ../iNaturalistAPI/docker-compose.override.yml.example | sed 's/username/'$USER'/' | sed 's/password/'$USER'/' > ../iNaturalistAPI/docker-compose.override.yml
cat >> ../iNaturalistAPI/docker-compose.override.yml<< EOF
    extra_hosts:
      - "host.docker.internal:host-gateway"
EOF

cat ../iNaturalistAPI/config_example.js | sed 's/"username"/"'$USER'"/' | sed 's/"password"/"'$USER'"/' > ../iNaturalistAPI/config.js

#Run the makefile to setup docker services
make services

nvm use

# Set up your gems, config files, and database
ruby bin/setup

#install node packages
npm install

#build ReactJS code
./node_modules/.bin/gulp webpack

#make sure rails command is available
rbenv rehash

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

#Setup elasticsearch indexes
rake es:rebuild