#!/bin/bash

# Add APT repositories
sudo add-apt-repository -y ppa:openjdk-r/ppa
echo "deb http://www.apache.org/dist/cassandra/debian 36x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
curl -s https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -

sudo apt-get update

# Install Java etc.
sudo apt-get -y install openjdk-8-jdk maven git

# Install Cassandra
sudo apt-get -y install cassandra

# Install JanusGraph - two options:
# 1. Place zip file in /vagrant shared folder if you want to avoid the clone+build process
#cp /vagrant/janusgraph-0.1.0-SNAPSHOT-hadoop2.zip ~/janusgraph-0.1.0-SNAPSHOT-hadoop2.zip

# 2. Clone Git repo and build
git clone https://github.com/JanusGraph/janusgraph.git ~/janusgraph-src
cd ~/janusgraph-src
mvn clean install -Pjanusgraph-release -Dgpg.skip=true -DskipTests=true
mv janusgraph-dist/janusgraph-dist-hadoop-2/target/janusgraph-0.1.0-SNAPSHOT-hadoop2.zip ~/janusgraph-0.1.0-SNAPSHOT-hadoop2.zip
rm -r ~/janusgraph-src

unzip -o janusgraph-0.1.0-SNAPSHOT-hadoop2.zip -d ~/janusgraph
rm janusgraph-0.1.0-SNAPSHOT-hadoop2.zip

# Set up Java
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> /home/vagrant/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /home/vagrant/.bashrc