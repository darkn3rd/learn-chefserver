#!/usr/bin/env bash

SYSTEMS="chefserver work node"
IPADDRESS=6

touch /etc/ssh/ssh_config

for SYSTEM in ${SYSTEMS}; do
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
  grep -q -F "192.168.50.${IPADDRESS} ${SYSTEM}" /etc/hosts || echo "192.168.50.${IPADDRESS} ${SYSTEM}" >> /etc/hosts
  ((IPADDRESS++))
done
