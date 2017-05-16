#!/bin/bash

echo install JDK 8, git ant wget curl vim unzip
sudo apt-get install software-properties-common python-software-properties -y
sudo add-apt-repository ppa:openjdk-r/ppa -y

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install openjdk-8-jdk git ant wget curl vim zip unzip -y

echo Move to JDK 1.8
sudo update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java 

if [[ ! -e /opt/orientdb ]] ; then  
	
echo Download packages
	# to use last stable version 1.7.8
	#wget http://www.orientdb.org/portal/function/portal/download/unknown@unknown.com/-/-/-/-/-/orientdb-community-1.7.8.tar.gz/false/false/linux -O /home/vagrant/orientdb-community.tar.gz -c
	
	#For version 2.0 milestone 3	
    wget -O /home/vagrant/orientdb-community.tar.gz http://www.orientechnologies.com/download.php?file=orientdb-community-2.0-M3.tar.gz&os=linux -c
	
	wget -O /home/vagrant/gremlin-server.zip http://tinkerpop.com/downloads/3.0.0.M4/gremlin-server-3.0.0.M4.zip -c
	wget -O /home/vagrant/gremlin-console.zip http://tinkerpop.com/downloads/3.0.0.M4/gremlin-console-3.0.0.M4.zip -c 
	

echo Unpacking 	
	
	cd /home/vagrant/
	sudo tar -zxvf orientdb-community.tar.gz 
	sudo unzip gremlin-server.zip 
	sudo unzip gremlin-console.zip 
	
echo Move directories to /opt/	
	# to use last stable version 1.7.8
	# sudo mv orientdb-community-1.7.8 /opt/orientdb
	
	#For version 2.0 mileston 1
	sudo mv orientdb-community-2.0-M3/ /opt/orientdb
	sudo mv gremlin-server-3.0.0.M4 /opt/gremlin-server
	sudo mv gremlin-console-3.0.0.M4 /opt/gremlin-console
	
echo Give rights	
	sudo chmod -R 777 /opt/orientdb/log
	sudo chmod -R 777 /opt/orientdb/bin
	sudo chmod -R 777 /opt/orientdb/config/
	sudo chmod -R 777 /opt/orientdb/databases/
	
	
echo Add Environment Variables
  echo "export ORIENTDB_ROOT_PASSWORD=\"RootPaSSword\"" >> /home/vagrant/.bashrc
  echo "export ORIENTDB_NODE_NAME=\"ORIENTDB_FIRSTNODE\"" >> /home/vagrant/.bashrc	
	
echo Add System variables and path
echo PATH $PATH

    echo "export ORIENTDB_HOME=\"/opt/orientdb\"" >> /home/vagrant/.bashrc
	echo "export PATH=\$PATH:\$ORIENTDB_HOME/bin" >> /home/vagrant/.bashrc
	
	echo "export GREMLIN_HOME=\"/opt/gremlin-console\"" >> /home/vagrant/.bashrc
	echo "export PATH=\$PATH:\$GREMLIN_HOME/bin" >> /home/vagrant/.bashrc
	
echo Move OrientDB conf file and Remove read permission permissions
	sudo cp /home/vagrant/orientdb-server-config.xml /opt/orientdb/config/

# Create user orientdb and assign ownership
	
	#sudo useradd -d /opt/orientdb -M -r -s /bin/false -U orientdb
	#sudo chown -R orientdb.orientdb orientdb*	
	#sudo usermod -a -G orientdb orientdb
	
echo Copy the init.d script:

	sudo cp /home/vagrant/orientdb.sh /etc/init.d/	 
	
echo Update the rc.d dirs

	cd /etc/init.d
	sudo update-rc.d orientdb.sh defaults
	sudo chmod 777 /etc/init.d/orientdb.sh
	
fi

	#/opt/orientdb/bin/server.sh
	sudo /etc/init.d/orientdb.sh start 
	
	# Prevent Gremlin Console in Orient_db (2.6) to be called by default. 3.0 is called.
	mv /opt/orientdb/bin/gremlin.sh /opt/orientdb/bin/gremlin_26.sh
	
	cd /opt/gremlin-server
	sudo bin/gremlin-server.sh config/gremlin-server-classic.yaml &
	
	
