#!/bin/sh
##### Fetch Global Data
CONFIG="/vagrant/.config"
JSON_DATA=$($CONFIG/JSON.sh -l < $CONFIG/global.json | grep -w '"server"')

##### Local Variables
PACKAGE=$(echo "${JSON_DATA}" | grep '"package"' | awk '{ print $2 }' | tr -d '"')
PKGPATH=/vagrant/packages/${PACKAGE}

# Install Package if it is available and not installed already
[ -f ${PKGPATH} ] && rpm -q chef-server-core > /dev/null 2>&1 || sudo rpm -Uvh ${PKGPATH}

# Set SELinux to Permissive
[ "$(getenforce)" = "Permissive" ] || setenforce Permissive

# Disable Qpid
if $(rpm -qa | grep -q qpid); then
  echo "Chef Server Setup: Disabling QPid"
  service qpidd stop
  chkconfig --del qpidd
fi
