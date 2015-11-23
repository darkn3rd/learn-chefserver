#!/bin/sh
# NOTE: THIS IS RUN ON HOST SYSTEM
##### Fetch Global Data
CONFIG="../.config"
JSON_DATA=$($CONFIG/JSON.sh -l < $CONFIG/global.json | grep '"client"')

##### Local Variables
PACKAGE=$(echo ${JSON_DATA} | grep '"package"' | awk '{ print $2 }' | tr -d '"')
eval PACKAGE_URL=$(echo "${JSON_DATA}" | grep '"url"' | awk '{ print $2 }' | tr -d '"')

##### Download Locally if file does not exist
[ -e ${PACKAGE} ] || curl -o ${PACKAGE} ${PACKAGE_URL}
