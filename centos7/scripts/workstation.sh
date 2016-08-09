#!/usr/bin/env bash
# NAME: workstation.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
# UPDATED:
#   * 2016-08-06 - hostname based script, modularized
#
# PURPOSE: Copies chef repository, including private keys needed for access to
#  the chef server, as well as SSL certificate from the Chef Server.
# DEPENDENCIES:
#  * Provisioned Chef Server
# NOTES:
#  * This script will be run on the guest operating system

#setup_vim

PKG_PATH="/vagrant/packages"
PKG_MANIFEST="/vagrant/config/packages.csv"
SCRIPTDIR="/vagrant/scripts"
SCRIPTLIB="${SCRIPTDIR}/libs"
DEV_USER='vagrant'
CHEF_USER_CONFIG='/vagrant/.chef'
CHEF_STARTER='/vagrant/chef-starter'
KEY_PATH="/vagrant/config"
DATABAG_SECRET_KEY="${KEY_PATH}/encrypted_data_bag_secret"

${SCRIPTDIR}/setup-base.sh # Configure SSH and Hosts Files

. ${SCRIPTLIB}/chefworkstation.src

# Generate Secret Databag For Future Encryption
[ -f ${DATABAG_SECRET_KEY} ] || gen_data_bag_secret ${DATABAG_SECRET_KEY}

fetch_chefdk
install_chefdk
config_user ${DEV_USER} ${CHEF_USER_CONFIG} ${DATABAG_SECRET_KEY}
setup_chef_starter ${DEV_USER} ${CHEF_USER_CONFIG} ${CHEF_STARTER}

# Copy optional Test Script
cp ${SCRIPTDIR}/test-chef.sh /home/${DEV_USER}/test_chef
chmod +x /home/${DEV_USER}/test_chef
