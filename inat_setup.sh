#!/usr/bin/env bash

cd ../inaturalist

# Set up your gems, config files, and database
ruby bin/setup

# Watch the output for errors! In particular, make sure the database gets
# created correctly. If it doesn't check the settings in config/database.yml
# Note that you will need to fill out some of the config YML files in config/ to
# get absolutely everything working, especially third party services.