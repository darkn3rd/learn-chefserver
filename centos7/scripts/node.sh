#!/usr/bin/env bash
# NAME: node.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-24
# UPDATED:
#   * 2016-08-06 - hostname based script, modularized
#
# PURPOSE: Configures Chef Node with opetioanl secret key
# NOTES:
#  * This script will be run on the guest operating system

##### Install Chef Client
PKG_PATH="/vagrant/packages"
PKG_MANIFEST="/vagrant/config/packages.csv"
SCRIPTDIR="/vagrant/scripts"
SCRIPTLIB="${SCRIPTDIR}/libs"

${SCRIPTDIR}/setup-base.sh    # Configure SSH and Hosts Files
. ${SCRIPTLIB}/chefclient.src # Source Library

fetch_chef
install_chef            # Install Client

##### Install Existing Databag Secret
KEY_PATH="/vagrant/config"
DATABAG_SECRET_KEY="${KEY_PATH}/encrypted_data_bag_secret"
# Install Secret
install_databag_secret "${DATABAG_SECRET_KEY}"
