#!/usr/bin/env bash

sudo -u postgres -H -- psql -c "CREATE ROLE $USER LOGIN SUPERUSER CREATEDB"
sudo -u postgres -H -- psql -c "ALTER ROLE $USER WITH PASSWORD '$USER'"

echo "*:*:*:$USER:$USER" > ~/.pgpass
chmod u=rw,og= ~/.pgpass