#!/bin/sh
# NOTE: THIS IS RUN ON HOST SYSTEM
#  This package works for Ubuntu 10.04, 12.04, 14.04
CONFIG="../.config"
PACKAGE_TYPES="manage reporting"

##### Test for Wget tool (needed for redirects)
[ -z $(which wget) ] && { echo "ERROR: Wget not found. Install wget"; exit 1 ; }

for TYPE in $PACKAGE_TYPES; do
   ##### Fetch Global Data
   JSON_DATA=$($CONFIG/JSON.sh -l < $CONFIG/global.json | grep "\"$TYPE\"")
   ##### Local Variables
   PACKAGE=$(echo "${JSON_DATA}" | grep '"package"' | awk '{ print $2 }' | tr -d '"')
   eval PACKAGE_URL=$(echo "${JSON_DATA}" | grep '"url"' | awk '{ print $2 }' | tr -d '"')
   ##### Download Locally
   echo "Downloading $PACKAGE"
   [ -e ${PACKAGE} ] || wget -O ${PACKAGE} ${PACKAGE_URL}
done
