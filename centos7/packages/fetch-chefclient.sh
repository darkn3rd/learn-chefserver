#!/bin/sh
# NAME: fetch-chefclient.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
#
# PURPOSE: Downloads Chef Client from Opscode
# DEPENDENCIES:
#  * POSIX Shell, POSIX Commands (awk, grep), Curl
#  * Global Configuration - JSON.sh, global.json
# NOTES:
#  * This script should be run on the host system (Linux/OSX/CygWin)

##### Fetch Global Data
CONFIG="../.config"
JSON_DATA=$($CONFIG/JSON.sh -l < $CONFIG/global.json | grep '"client"')

##### Local Variables
PACKAGE=$(echo ${JSON_DATA} | grep '"package"' | awk '{ print $2 }' | tr -d '"')
eval PACKAGE_URL=$(echo "${JSON_DATA}" | grep '"url"' | awk '{ print $2 }' | tr -d '"')

##### Download Locally if file does not exist
[ -e ${PACKAGE} ] || curl -o ${PACKAGE} ${PACKAGE_URL}
