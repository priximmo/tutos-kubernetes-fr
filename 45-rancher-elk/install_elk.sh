#!/bin/bash

VERSION="7.6.1"
#VERSION="7.4.1"
IP=$(hostname -I | cut -d " " -f 2)


# Checking whether user has enough permission to run this script
sudo -n true
if [ $? -ne 0 ]
    then
        echo "This script requires user to have passwordless sudo access"
        exit
fi

dependency_check_deb() {
java -version
if [ $? -ne 0 ]
    then
        # Installing Java 7 if it's not installed
        sudo apt-get install openjdk-7-jre-headless -y
    # Checking if java installed is less than version 7. If yes, installing Java 7. As logstash & Elasticsearch require Java 7 or later.
    elif [ "`java -version 2> /tmp/version && awk '/version/ { gsub(/"/, "", $NF); print ( $NF < 1.7 ) ? "YES" : "NO" }' /tmp/version`" == "YES" ]
        then
            sudo apt-get install openjdk-7-jre-headless -y
fi
}

dependency_check_rpm() {
    java -version
    if [ $? -ne 0 ]
        then
            #Installing Java 7 if it's not installed
            sudo yum install jre-1.7.0-openjdk -y
        # Checking if java installed is less than version 7. If yes, installing Java 7. As logstash & Elasticsearch require Java 7 or later.
        elif [ "`java -version 2> /tmp/version && awk '/version/ { gsub(/"/, "", $NF); print ( $NF < 1.7 ) ? "YES" : "NO" }' /tmp/version`" == "YES" ]
            then
                sudo yum install jre-1.7.0-openjdk -y
    fi
}

debian_elk() {
    # resynchronize the package index files from their sources.
    sudo apt-get update
    # Downloading debian package of logstash
    sudo wget --directory-prefix=/opt/ https://artifacts.elastic.co/downloads/logstash/logstash-${VERSION}.deb
    # Install logstash debian package
    sudo dpkg -i /opt/logstash*.deb
    # Downloading debian package of elasticsearch
    sudo wget --directory-prefix=/opt/ https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${VERSION}-amd64.deb
    # Install debian package of elasticsearch
    sudo dpkg -i /opt/elasticsearch*.deb
    # Download kibana tarball in /opt
    sudo wget --directory-prefix=/opt/ https://artifacts.elastic.co/downloads/kibana/kibana-${VERSION}-amd64.deb
    # Extracting kibana tarball
    sudo dpkg -i /opt/kibana*.deb
    # Starting The Services
    sudo service logstash start
    sudo service elasticsearch start
    sudo service kibana start
}

rpm_elk() {
    #Installing wget.
    sudo yum install wget -y
    # Downloading rpm package of logstash
    sudo wget --directory-prefix=/opt/ https://artifacts.elastic.co/downloads/logstash/logstash-${VERSION}.rpm
    # Install logstash rpm package
    sudo rpm -ivh /opt/logstash*.rpm
    # Downloading rpm package of elasticsearch
    sudo wget --directory-prefix=/opt/ https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${VERSION}-x86_64.rpm
    # Install rpm package of elasticsearch
    sudo rpm -ivh /opt/elasticsearch*.rpm
    # Download kibana tarball in /opt
    sudo wget --directory-prefix=/opt/ https://artifacts.elastic.co/downloads/kibana/kibana-${VERSION}-x86_64.rpm
    # Extracting kibana tarball
    sudo rpm -ivh /opt/kibana*.rpm
    # Starting The Services
    sudo systemctl enable logstash
    sudo systemctl start logstash
    sudo systemctl enable elasticsearch
    sudo systemctl start elasticsearch
    sudo systemctl enable kibana
    sudo systemctl start kibana
}

vagrant_steps(){
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sed -i s/"#server.host: \"localhost\""/"server.host: \"0.0.0.0\""/g /etc/kibana/kibana.yml
sudo systemctl restart kibana
sed -i s/"#discovery.seed_hosts:".*/"discovery.seed_hosts: [\"${IP}\", \"127.0.0.1\"]"/g /etc/elasticsearch/elasticsearch.yml
sed -i s/"#network.host:".*/"network.host: 0.0.0.0"/g /etc/elasticsearch/elasticsearch.yml
sudo systemctl restart elasticsearch
}

# Installing ELK Stack
if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]
    then
        echo " It's a Debian based system"
        dependency_check_deb
        debian_elk
elif [ "$(grep -Ei 'fedora|redhat|centos' /etc/*release)" ]
    then
        echo "It's a RedHat based system."
        dependency_check_rpm
        rpm_elk
				vagrant_steps
else
    echo "This script doesn't support ELK installation on this OS."
fi
