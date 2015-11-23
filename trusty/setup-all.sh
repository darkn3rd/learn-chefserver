#!/usr/bin/env bash

##### Fetch Global Data
CONFIG="/vagrant/.config"
[ -e $CONFIG/global.json -o -e $CONFIG/JSON.sh ] || { echo "ERROR: No global configuration exists. Exiting"; exit 1; }
JSON_DATA=$($CONFIG/JSON.sh -l < $CONFIG/global.json | grep '"ipaddr"')
##### Local Variables
SYSTEMS=$(echo "${JSON_DATA}" | awk 'BEGIN { FS = "\"" } { print $4}' )

cp /dev/null /etc/ssh/ssh_config

for SYSTEM in $SYSTEMS; do
  if ! grep -q -F "Host ${SYSTEM}" /etc/ssh/ssh_config; then
    ### CREATE GLOBAL SSH CONFIG
    cat <<-CONFIG_EOF >> /etc/ssh/ssh_config
Host ${SYSTEM}
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  IdentitiesOnly yes
  User vagrant
  IdentityFile /vagrant/.vagrant/machines/${SYSTEM}/virtualbox/private_key
  PasswordAuthentication no
CONFIG_EOF
  fi

  ### CREATE HOSTS
  IPADDRESS=$(echo "${JSON_DATA}" | grep "${SYSTEM}" | awk '{ print $2 }' | tr -d '"')
  grep -q -F "${IPADDRESS} ${SYSTEM}" /etc/hosts || echo "${IPADDRESS} ${SYSTEM}" >> /etc/hosts
done
