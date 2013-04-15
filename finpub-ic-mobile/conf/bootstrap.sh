#!/usr/bin/env bash

# Remove content of the web-root and link it to Vagrant's shared folder
echo "[Linking web root to synced folder]"
rm -rfv /var/www
ln -sfv /vagrant-project /var/www

# Install required packages
echo "[Installing packages]"
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -q -y install apache2 php5 php5-cli php5-curl vim php-pear maven git-core bash-completion

# Configure default apache vhost
echo "[Configuring Apache]"
cp -v /vagrant/conf/apache-default-vhost.conf /etc/apache2/sites-available/default
a2ensite default

# Restart Apache
apache2ctl graceful

# Configure bash, git and vim
echo "[Configuring bash, git and vim]"
cp -v /vagrant/conf/bashrc     /etc/bash.bashrc
cp -v /vagrant/conf/gitconfig  /etc/gitconfig
cp -v /vagrant/conf/vimrc      /etc/vim/vimrc.local

# Run Maven (under Vagrant user)
echo "[Building Maven]"
export JAVA_HOME=/usr/lib/jvm/default-java/
su -c "cd /var/www/ && mvn -q compile -Dminimize=false" vagrant

echo "[Provisioning finished]"