#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo Pulling down inaturalist
if [ -d "$DIR/../inaturalist" ]; then
  git -C $DIR/../inaturalist pull
else
  git -C $DIR/.. clone https://github.com/inaturalist/inaturalist.git
fi