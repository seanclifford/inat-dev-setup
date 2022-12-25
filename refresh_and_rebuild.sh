#!/usr/bin/env bash

#To be run to get latest changes and apply them. Will pull down current branches.

set -e

. pull_down_inaturalist_repo.sh

. install_nodejs.sh

cd ../inaturalist

#Ensure any docker changes are refreshed
make services

# Install any missing gems and migrate db
ruby bin/update

#install missing node packages
npm install

#rebuild ReactJS code
npm run webpack

# Generate js translation files
echo generating js translation files
rake inaturalist:generate_translations_js > /dev/null

cd ../iNaturalistAPI

#install missing node packages
npm install

echo "REFRESH COMPLETE!"