#!/bin/sh
##### Fetch Global Data
CONFIG="/vagrant/.config"
JSON_DATA=$($CONFIG/JSON.sh -l < $CONFIG/global.json | grep '"client"')

##### Local Variables
PACKAGE=$(echo "${JSON_DATA}" | grep '"package"' | awk '{ print $2 }' | tr -d '"')
PKGPATH=/vagrant/packages/${PACKAGE}

##### Install Package If it Exists and not installed already
[ -f ${PKGPATH} ] && rpm -q chef > /dev/null 2>&1 || sudo rpm -Uvh ${PKGPATH}
