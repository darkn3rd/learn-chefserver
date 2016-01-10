#!/bin/sh
# NAME: setup-chefserver.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
#
# PURPOSE: Installs Chef Core Server on Ubuntu 14.04 Trusty Tahr.
#  Disables or Configures AppArmor.
# DEPENDENCIES:
#  * Updated package links
#  * POSIX Shell, POSIX Commands (awk, grep)
#  * Global Configuration - JSON.sh, global.json
# NOTES:
#  * This script will be run on the guest operating system

##### Fetch Global Data
CONFIG="/vagrant/.config"
JSON_DATA=$($CONFIG/JSON.sh -l < $CONFIG/global.json | grep -w '"server"')

##### Local Variables
PACKAGE=$(echo "${JSON_DATA}" | grep '"package"' | awk '{ print $2 }' | tr -d '"')
PKGPATH=/vagrant/packages/${PACKAGE}

# Install Package if it is available and not installed already
[ -f ${PKGPATH} ] && dpkg -s chef-server-core > /dev/null 2>&1 || dpkg -i ${PKGPATH}

# SET APPARMOR TO COMPLAIN MODE
apt-get install -y apparmor-utils
sudo aa-complain /etc/apparmor.d/*

# REMOVE APPARMOR
# invoke-rc.d apparmor kill
# update-rc.d -f apparmor remov
