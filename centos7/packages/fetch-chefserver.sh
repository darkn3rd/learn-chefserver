#!/bin/sh
# NOTE: THIS IS RUN ON HOST SYSTEM
#  This package works for CentOS 7 or RHEL 7
PACKAGE=chef-server-core-12.3.0-1.el7.x86_64.rpm
URL=https://packagecloud.io/chef/stable/packages/el/7/${PACKAGE}/download

# Test for Wget tool
[ -z $(which wget) ] && { echo "ERROR: Wget not found. Install wget"; exit 1 ; }

# Download Locally
[ -e ${PACKAGE} ] || wget -O ${PACKAGE} ${URL}
