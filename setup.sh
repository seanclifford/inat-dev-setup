#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo Pulling down inaturalist
git -C $DIR/.. clone https://github.com/inaturalist/inaturalist.git