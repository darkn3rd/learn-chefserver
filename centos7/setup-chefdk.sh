#!/bin/sh
# NAME: setup-chefdk.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
#
# PURPOSE: Installs Chef Development Kit on on Ubuntu 14.04 Trusty Tahr.
# DEPENDENCIES:
#  * Updated package links
#  * POSIX Shell, POSIX Commands (awk, grep)
#  * Global Configuration - JSON.sh, global.json
# NOTES:
#  * This script will be run on the guest operating system

##### Fetch Global Data
CONFIG="/vagrant/.config"
JSON_DATA=$($CONFIG/JSON.sh -l < $CONFIG/global.json | grep '"devkit"')

##### Local Variables
PACKAGE=$(echo "${JSON_DATA}" | grep '"package"' | awk '{ print $2 }' | tr -d '"')
PKGPATH=/vagrant/packages/${PACKAGE}

# Install Package If it Exists and not installed already
[ -f ${PKGPATH} ] && rpm -q chefdk > /dev/null 2>&1  || sudo rpm -Uvh ${PKGPATH}
