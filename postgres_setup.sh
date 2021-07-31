#!/usr/bin/env bash

if ! command grep -qc ' PGHOST' ~/.bashrc; then
      echo "=> Appending PGHOST env var to ~/.bashrc"
      PGHOST_ENV="\\n#Sets the default Postgres host\\nexport PGHOST=\"localhost\"\\n"
      command printf "$PGHOST_ENV" >> ~/.bashrc
else
      echo "=> PGHOST env var already in ~/.bashrc"
fi

echo "*:*:*:$USER:$USER" > ~/.pgpass
chmod u=rw,og= ~/.pgpass