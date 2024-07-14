#!/usr/bin/env bash

# From https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

NVM_VER=$(get_latest_release "nvm-sh/nvm")

echo "installing nvm $NVM_VER"
export NVM_DIR="$HOME/.config/.nvm"
mkdir -p $NVM_DIR
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VER/install.sh | bash

# setup nvm command to run right now
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# install the correct version of node
NODE_VER=$(cat $DIR/../inaturalist/.nvmrc)
echo "installing node $NODE_VER with nvm"
nvm install $NODE_VER
nvm alias default $NODE_VER

# upgrade npm version
nvm install-latest-npm

# Set the NODE_ENV to development if it's not already
if ! command grep -qc ' NODE_ENV' ~/.bashrc; then
      echo "=> Appending NODE_ENV env var to ~/.bashrc"
      NODE_ENV="\\n#Sets the default Node environment to development\\nexport NODE_ENV=\"development\"\\n"
      command printf "$NODE_ENV" >> ~/.bashrc
else
      echo "=> NODE_ENV env var already in ~/.bashrc"
fi