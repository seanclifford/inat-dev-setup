#!/usr/bin/env bash

echo installing rbenv with rbenv-installer
wget -q https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer -O- | bash

echo initialising rbenv
~/.rbenv/bin/rbenv init

RUBY_VER=$(cat $DIR/../inaturalist/.ruby-version)
echo installing ruby $RUBY_VER with rbenv
 ~/.rbenv/bin/rbenv install $RUBY_VER

 echo add \~/.rbenv/bin to your PATH and eval \"\$\(rbenv init - bash\)\" is added to .bashrc before running the next sh script