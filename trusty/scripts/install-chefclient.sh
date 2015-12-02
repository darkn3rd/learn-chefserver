#!/bin/sh
# NAME: setup-chefclient.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-12-01
#
# PURPOSE: Installs recent Chef Client on Ubuntu 14.04 Trusty Tahr.
# DEPENDENCIES:
#  * Updated package links
#  * POSIX Shell, POSIX Commands (awk, grep, cut, tr)
#  * Global Configuration - JSON.sh, global.json
#  * Package downloaded previously
# NOTES:
#  * This script will be run on the guest operating system
#  * This removes older version of Chef Client, especially as earlier versions,
#    e.g. version 11.8.2, are not compatible with Chef Server 12.3+ and
#    ChefDK 0.9+

##### Fetch Global Data
CONFIG="/vagrant/.config"
JSON_DATA=$($CONFIG/JSON.sh -l < $CONFIG/global.json | grep '"client"')

##### Local Variables
PACKAGE=$(echo "${JSON_DATA}" | grep '"package"' | awk '{ print $2 }' | tr -d '"')
PKGPATH=/vagrant/packages/${PACKAGE}
PKG_VER=$(echo ${PACKAGE} | awk -F "_" '{ print $2 }' | cut -d. -f1,2 | tr -d '.')

##### Exit if Package file is not found
[ -f ${PKGPATH} ] || { echo "ERROR: ${PKGPATH} not found."; exit 1 ; }

##### Install Package if not installed already or if older one exists
if dpkg -s chef > /dev/null 2>&1; then
  CURR_VER=$(dpkg-query -W -f='${Version}\n' chef | cut -d. -f1,2 | tr -d '.')
  if [ ${PKG_VER} -ge ${CURR_VER} ]; then
    rm -rf /etc/chef /var/chef   # purge existing files
    dpkg -r chef                 # remove older chef package
    dpkg -i ${PKGPATH}           # install target chefclient package
  fi
else
  dpkg -i ${PKGPATH}             # install target chefclient ppackage
fi
