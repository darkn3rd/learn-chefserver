#!/bin/sh
# NAME: chef-starter.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-24
#
# PURPOSE: Copies chef repository, including private keys needed for access to
#  the chef server, as well as SSL certificate from the Chef Server.
# DEPENDENCIES:
#  * Provisioned Chef Server
#  * ChefDK previously installed
# NOTES:
#  * This script will be run on the guest operating system

#### copy chef-starter repository
su vagrant -c 'cp -r /vagrant/chef-repo ~vagrant'
#### copy chef configuration directory and keys
su vagrant -c 'cp -v /vagrant/.chef/*.pem ~vagrant/chef-repo/.chef'
#### install certificate into chef's trusted certificate area
su vagrant -c 'cd ~vagrant/chef-repo; knife ssl fetch'
