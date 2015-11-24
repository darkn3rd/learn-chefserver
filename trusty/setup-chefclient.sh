#!/bin/sh
# NAME: setup-chefclient.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
#
# PURPOSE: Installs recent Chef Client on Ubuntu 14.04 Trusty Tahr.
# DEPENDENCIES:
#  * Updated package links
#  * POSIX Shell, POSIX Commands (awk, grep)
#  * Global Configuration - JSON.sh, global.json
# NOTES:
#  * This script will be run on the guest operating system
#  * `knife bootstrap` command seems to install incompatible version of
#    chef-client, so this script remedies the issue.


##### Fetch Global Data
CONFIG="/vagrant/.config"
JSON_DATA=$($CONFIG/JSON.sh -l < $CONFIG/global.json | grep '"client"')

##### Local Variables
PACKAGE=$(echo "${JSON_DATA}" | grep '"package"' | awk '{ print $2 }' | tr -d '"')
PKGPATH=/vagrant/packages/${PACKAGE}

##### Install Package If it Exists and not installed already
[ -f ${PKGPATH} ] && dpkg -s chef > /dev/null  2>&1 || dpkg -i ${PKGPATH}
