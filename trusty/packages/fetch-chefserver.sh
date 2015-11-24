#!/bin/sh
# NAME: fetch-chefserver.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
#
# PURPOSE: Downloads Chef Core Server from Opscode
# DEPENDENCIES:
#  * POSIX Shell, POSIX Commands (awk, grep)
#  * GNU Wget 1.15+ (supports URLs w/ redicrection)
#  * Global Configuration - JSON.sh, global.json
# NOTES:
#  * This script should be run on the host system (Linux/OSX/CygWin)

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
