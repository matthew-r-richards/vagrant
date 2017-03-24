#!/bin/bash

# Install Java
sudo add-apt-repository -y ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get -y install openjdk-8-jdk

# Install Apache Tinkerpop
wget -q http://mirror.switch.ch/mirror/apache/dist/tinkerpop/3.2.4/apache-tinkerpop-gremlin-console-3.2.4-bin.zip
unzip -y apache-tinkerpop-gremlin-console-3.2.4-bin.zip
rm apache-tinkerpop-gremlin-console-3.2.4-bin.zip

# Set up Java
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> /home/vagrant/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /home/vagrant/.bashrc