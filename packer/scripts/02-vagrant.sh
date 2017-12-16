#!/bin/sh -eux

HOME_DIR="/home/vagrant";
PUBKEY_URL="https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub";
mkdir -p $HOME_DIR/.ssh;
wget --no-check-certificate "$PUBKEY_URL" -O $HOME_DIR/.ssh/authorized_keys;
chown -R vagrant $HOME_DIR/.ssh;
chmod -R go-rwsx $HOME_DIR/.ssh;
