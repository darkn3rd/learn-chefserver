#!/bin/sh
# NOTE: THIS IS RUN ON HOST SYSTEM
#  This package works for Ubuntu 10.04, 12.04, 14.04
PACKAGE=chef-server-core_12.2.0-1_amd64.deb
URL=https://packagecloud.io/chef/stable/packages/ubuntu/trusty/${PACKAGE}/download

# Test for Wget tool
[ -z $(which wget) ] && { echo "ERROR: Wget not found. Install wget"; exit 1 ; }

# Download Locally
[ -e ${PACKAGE} ] || wget -O ${PACKAGE} ${URL}
