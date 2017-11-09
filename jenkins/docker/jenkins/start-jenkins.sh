#!/bin/sh
sudo chown :docker /var/run/docker.sock
/bin/tini -- /usr/local/bin/jenkins.sh