#!/bin/sh

# Target Package
PACKAGE=chef-server-core_12.2.0-1_amd64.deb

# Install Package if it is available and not installed already
[ -f /vagrant/${PACKAGE} ] && dpkg -s chef-server-core > /dev/null || dpkg -i /vagrant/${PACKAGE}

# SET APPARMOR TO COMPLAIN MODE
apt-get install -y apparmor-utils
sudo aa-complain /etc/apparmor.d/*

# REMOVE APPARMOR
# invoke-rc.d apparmor kill
# update-rc.d -f apparmor remov
