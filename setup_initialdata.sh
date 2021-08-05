#!/usr/bin/env bash

cd ../inaturalist

#Setup an initial site
rails r "Site.create( name: 'iNaturalist', url: 'http://localhost:3000' )"

#Load some seed data...
# Load source records for citation
rails r tools/load_sources.rb
# Load the basic iconic taxa to get the taxonomy started
rails r tools/load_iconic_taxa.rb
# Generate translation files
rake inaturalist:generate_translations_js

# Add the basic countries. US states and counties optional... They take up a bit of space
rails r tools/import_natural_earth_countries.rb
#rails r tools/import_us_states.rb
#rails r tools/import_us_counties.rb

rails r "User.create( login: 'testerson', password: 'tester', password_confirmation: 'tester', email: 'test@example.com' )"
rails r tools/load_dummy_observations.rb

echo "run: make services-api in a terminal window to run the API"
echo "run: rails s -b 127.0.0.1 in a terminal window to run the inaturalist website (accessable on http://127.0.0.1:3000)"