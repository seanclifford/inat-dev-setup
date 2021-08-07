#!/usr/bin/env bash

echo "installing docker"
wget -qO- https://get.docker.com | bash

echo "allowing docker to be run by the $USER account without sudo  (requires logout/restart to complete)"
groupadd docker
usermod -aG docker $USER

echo "install docker-compose"
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose