#!/bin/sh

# Target Package
PACKAGE=chef-server-core_12.2.0-1_amd64.deb
PKGPATH=/vagrant/packages/${PACKAGE}

# Install Package if it is available and not installed already
[ -f ${PKGPATH} ] && dpkg -s chef-server-core > /dev/null 2>&1 || dpkg -i ${PKGPATH}


# SET APPARMOR TO COMPLAIN MODE
apt-get install -y apparmor-utils
sudo aa-complain /etc/apparmor.d/*

# REMOVE APPARMOR
# invoke-rc.d apparmor kill
# update-rc.d -f apparmor remov
