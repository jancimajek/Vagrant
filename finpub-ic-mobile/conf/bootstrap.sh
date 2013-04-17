#!/usr/bin/env bash

echo "[Begining project-specific provisioning]"

# Remove content of the web-root and link it to Vagrant's shared folder
echo "[Linking web root to synced folder]"
rm -rfv /var/www
ln -sfv /vagrant-project /var/www

# Install required packages
echo "[Installing packages]"
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -q -y install apache2 php5 php5-cli php5-curl php-pear maven

# Configure default apache vhost
echo "[Configuring Apache]"
cp -v /vagrant/conf/apache-default-vhost.conf /etc/apache2/sites-available/default
a2ensite default
a2enmod rewrite

# Restart Apache
apache2ctl graceful

# Run Maven (under Vagrant user)
#echo "[Building Maven]"
#export JAVA_HOME=/usr/lib/jvm/default-java/
#su -c "cd /var/www/ && mvn -q compile -Dminimize=false" vagrant

echo "[Project-specific provisioning finished]"