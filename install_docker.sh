#!/usr/bin/env bash

echo installing docker
wget -qO- https://get.docker.com | bash

echo allowing docker to be run by the $USER account without sudo (requires logout/restart to complete)
sudo groupadd docker
sudo usermod -aG docker $USER