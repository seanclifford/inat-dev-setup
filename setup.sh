#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo Pulling down inaturalist
if [ -d "$DIR/../inaturalist" ]; then
  git -C $DIR/../inaturalist pull
else
  git -C $DIR/.. clone https://github.com/inaturalist/inaturalist.git
fi

echo installing some ruby build dependencies
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev

echo installing rbenv with rbenv-installer
wget -q https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer -O- | bash

echo initialising rbenv
~/.rbenv/bin/rbenv init

RUBY_VER=$(cat $DIR/../inaturalist/.ruby-version)
echo installing ruby $RUBY_VER with rbenv
 ~/.rbenv/bin/rbenv install $RUBY_VER