#!/bin/sh
# NOTE: THIS IS RUN ON HOST SYSTEM
#  This package works for Ubuntu 10.04, 12.04, 14.04
PACKAGE=chef-server-core-12.3.0-1.el7.x86_64.rpm
URL=https://packagecloud.io/chef/stable/packages/el/7/${PACKAGE}/download

# Test for Wget tool
[ -z $(which wget) ] && { echo "ERROR: Wget not found. Install wget"; exit 1 ; }

# Copy to Downloads Folder (Ubuntu/Mac OS X)
[ -e ~/Downloads/${PACKAGE} ] || wget -O ~/Downloads/${PACKAGE} ${URL}
# Copy Locally to make available to guest systems
[ -e ${PACKAGE} ] || cp -v ~/Downloads/${PACKAGE} ${PACKAGE}
