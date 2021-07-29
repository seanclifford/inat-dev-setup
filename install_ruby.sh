#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo installing rbenv with rbenv-installer
wget -q https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer -O- | bash

echo initialising rbenv
~/.rbenv/bin/rbenv init

RUBY_VER=$(cat $DIR/../inaturalist/.ruby-version)
echo installing ruby $RUBY_VER with rbenv
 ~/.rbenv/bin/rbenv install $RUBY_VER


if ! command grep -qc '/.rbenv/bin/' ~/.bashrc; then
      echo "=> Appending rbenv setup strings to ~/.bashrc"
      RUBY_INIT="\\n#This adds rbenv to the path and inits it in the current directory\\nexport PATH=\$PATH:~/.rbenv/bin/\\neval \"\$(rbenv init - bash)\"\\n"
      command printf "$RUBY_INIT" >> ~/.bashrc
else
      echo "=> rbenv setup strings already in ~/.bashrc"
fi