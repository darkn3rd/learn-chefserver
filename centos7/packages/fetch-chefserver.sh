#!/bin/sh
# NOTE: THIS IS RUN ON HOST SYSTEM
#  This package works for CentOS 7 or RHEL 7
##### Fetch Global Data
CONFIG="../.config"
JSON_DATA=$($CONFIG/JSON.sh -l < $CONFIG/global.json | grep '"server"')

##### Local Variables
PACKAGE=$(echo "${JSON_DATA}" | grep '"package"' | awk '{ print $2 }' | tr -d '"')
eval PACKAGE_URL=$(echo "${JSON_DATA}" | grep '"url"' | awk '{ print $2 }' | tr -d '"')

##### Test for Wget tool (needed for redirects)
[ -z $(which wget) ] && { echo "ERROR: Wget not found. Install wget"; exit 1 ; }

##### Download Locally
[ -e ${PACKAGE} ] || wget -O ${PACKAGE} ${PACKAGE_URL}
