#!/usr/bin/env bash
# NAME: setup-all.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
#
# PURPOSE: Configures `/etc/hosts` and global ssh configuration for each
#  password-less system to system communication through ssh.
# DEPENDENCIES:
#  * GNU Bash, POSIX Commands (awk, grep)
#  * Global Configuration - JSON.sh, global.json
# NOTES:
#  * This script will be run on the guest operating system

##### Fetch Global Data
CONFIG="/vagrant/.config"
[ -e $CONFIG/global.json -o -e $CONFIG/JSON.sh ] || { echo "ERROR: No global configuration exists. Exiting"; exit 1; }
JSON_DATA=$($CONFIG/JSON.sh -l < $CONFIG/global.json | grep '"ipaddr"')
##### Local Variables
SYSTEMS=$(echo "${JSON_DATA}" | awk 'BEGIN { FS = "\"" } { print $4}' )

cp /dev/null /etc/ssh/ssh_config

for SYSTEM in $SYSTEMS; do
  # Copy Private Key Locally (vbox mounted dirs have strange persmissions)
  cp -v /vagrant/.vagrant/machines/${SYSTEM}/virtualbox/private_key /etc/ssh/${SYSTEM}_key
  chmod 644 /etc/ssh/${SYSTEM}_key

  # Add Entry to SSH Configuration if not already added
  if ! grep -q -F "Host ${SYSTEM}" /etc/ssh/ssh_config; then
    ### CREATE GLOBAL SSH CONFIG
    cat <<-CONFIG_EOF >> /etc/ssh/ssh_config
Host ${SYSTEM}
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  IdentitiesOnly yes
  User vagrant
  IdentityFile /etc/ssh/${SYSTEM}_key
  PasswordAuthentication no
CONFIG_EOF
  fi

  ### CREATE HOSTS
  IPADDRESS=$(echo "${JSON_DATA}" | grep "${SYSTEM}" | awk '{ print $2 }' | tr -d '"')
  grep -q -F "${IPADDRESS} ${SYSTEM}" /etc/hosts || echo "${IPADDRESS} ${SYSTEM}" >> /etc/hosts
done
