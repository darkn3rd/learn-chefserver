#!/bin/sh
# NAME: config-workstation.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
#
# PURPOSE: Copies chef repository, including private keys needed for access to
#  the chef server, as well as SSL certificate from the Chef Server.
# DEPENDENCIES:
#  * Provisioned Chef Server
#  * ChefDK previously installed
# NOTES:
#  * This script will be run on the guest operating system

# COPY CHEF-REPO w/ KEYS
su vagrant -c 'cp -r /vagrant/chef-repo ~vagrant'
# INSTALL KEY INTO TRUSTED KEY AREA
su vagrant -c 'cd ~vagrant/chef-repo; knife ssl fetch'
