#!/bin/sh
# NOTE: THIS IS RUN ON HOST SYSTEM
#  This package works for Ubuntu 10.04, 12.04, 14.04
PACKAGE=chef-server-core_12.2.0-1_amd64.deb
URL=https://packagecloud.io/chef/stable/packages/ubuntu/trusty/${PACKAGE}/download

[ -z $(which wget) ] && { echo "ERROR: Wget not found. Install wget"; exit 1 ; }

# Copy to Downloads Folder (Ubuntu/Mac OS X)
[ -e ~/Downloads/${PACKAGE} ] || wget -O ~/Downloads/${PACKAGE} ${URL}
# Copy Locally to make available to guest systems
[ -e ${PACKAGE} ] || cp -v ~/Downloads/${PACKAGE} ${PACKAGE}
