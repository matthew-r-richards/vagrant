#!/bin/bash

# Install docker-compose
sudo apt-get install -y python-pip
sudo pip install docker-compose

# Run the docker-compose script to bring up the docker containers
cd /docker
docker-compose up -d