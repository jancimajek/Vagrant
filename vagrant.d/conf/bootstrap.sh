#!/usr/bin/env bash

echo "[Beginning common provisioning]"

# Install required packages
echo "[Installing common packages]"
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -q -y install vim git-core bash-completion

# Configure bash, git and vim
echo "[Configuring bash, git and vim]"
cp -v /vagrant-common/bashrc     /etc/bash.bashrc
cp -v /vagrant-common/gitconfig  /etc/gitconfig
cp -v /vagrant-common/vimrc      /etc/vim/vimrc.local

echo "[Common provisioning finished]"