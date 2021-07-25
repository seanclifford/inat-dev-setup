#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo Pulling down inaturalist
if [ -d "$DIR/../inaturalist" ]; then
  git -C $DIR/../inaturalist pull
else
  git -C $DIR/.. clone https://github.com/inaturalist/inaturalist.git
fi

echo installing some dev dependencies...
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev libcurl4-openssl-dev libpq-dev

echo installing iNaturalist dependencies
sudo apt-get install -y imagemagick redis memcached postgis

echo attempting to start PostgreSQL
sudo systemctl start postgresql@12-main

echo installing nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

#setup nvm command to run right now
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

NODE_VER=$(cat $DIR/../inaturalist/.nvmrc)
echo installing node $NODE_VER with nvm
nvm install $NODE_VER

echo installing rbenv with rbenv-installer
wget -q https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer -O- | bash

echo initialising rbenv
~/.rbenv/bin/rbenv init

RUBY_VER=$(cat $DIR/../inaturalist/.ruby-version)
echo installing ruby $RUBY_VER with rbenv
 ~/.rbenv/bin/rbenv install $RUBY_VER

 echo add \~/.rbenv/bin to your PATH and eval \"\$\(rbenv init - bash\)\" is added to .bashrc before running the next sh script