#!/usr/bin/env bash
# NAME: chefserver.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
# UPDATED:
#   * 2016-08-06 - hostname based script, modularized
#
# PURPOSE: Download/Install/Configure Chef Server w/ features, admin, account,
#   and organization.
# DEPENDENCIES:
#  * Global Configuration (optional) - default.hsots, packages.csv
# NOTES:
#  * This script will be run on the guest operating system

# Configure SSH and Hosts Files
./setup-base.sh

PKG_PATH="/vagrant/packages"
PKG_MANIFEST="/vagrant/config/packages.csv"
SCRIPTDIR="/vagrant/scripts"
SCRIPTLIB="${SCRIPTDIR}/libs"

. ${SCRIPTLIB}/chefserver.src

# Download and Install Chef Server
fetch_chefserver
install_chefserver

# Variables used to configure Chef Server
KEY_LOCATION='/vagrant/.chef'
ADMIN_USER_NAME='vagrant'
ADMIN_FIRST_NAME='vagrant'
ADMIN_LAST_NAME='vagrant'
ADMIN_EMAIL='vagrant@chefserver.dev'
ADMIN_PASSWD='vagrant'
ORG_LONG_NAME='Vagrant Development Team'
ORG_SHORT_NAME='vagrantdev'

# Configure Chef Server with Packages, Admin User, and Organization
config_chefserver ${KEY_LOCATION} ${ADMIN_USER_NAME} ${ADMIN_FIRST_NAME} \
   ${ADMIN_LAST_NAME} ${ADMIN_EMAIL} ${ADMIN_PASSWD} \
   ${ORG_SHORT_NAME} ${ORG_LONG_NAME}
