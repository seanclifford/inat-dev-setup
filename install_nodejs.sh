#!/usr/bin/env bash

echo installing nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

#setup nvm command to run right now
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

NODE_VER=$(cat $DIR/../inaturalist/.nvmrc)
echo installing node $NODE_VER with nvm
nvm install $NODE_VER