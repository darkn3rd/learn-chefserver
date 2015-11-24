#!/bin/sh
# NAME: fetch-packages.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
#
# PURPOSE: Downloads Packages needed for Reporting and Management console
#  ChefServer features.
# DEPENDENCIES:
#  * POSIX Shell, POSIX Commands (awk, grep)
#  * GNU Wget 1.15+ (supports URLs w/ redicrection)
#  * Global Configuration - JSON.sh, global.json
# NOTES:
#  * This script should be run on the host system (Linux/OSX/CygWin)

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
