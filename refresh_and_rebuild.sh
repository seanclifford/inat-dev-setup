#!/usr/bin/env bash

#To be run to get latest changes and apply them. Will pull down current branches.

set -e

. pull_down_inaturalist_repo.sh

. install_nodejs.sh

cd ../inaturalist

#Ensure any docker changes are refreshed
make services

# Install any missing gems
bundle check || bundle install

#run any pending migrations
rails db:migrate RAILS_ENV=development

#install missing node packages
npm install

#rebuild ReactJS code
./node_modules/.bin/gulp webpack

# Generate js translation files
echo generating js translation files
rake inaturalist:generate_translations_js > /dev/null

cd ../iNaturalistAPI

#install missing node packages
npm install

echo "REFRESH COMPLETE!"