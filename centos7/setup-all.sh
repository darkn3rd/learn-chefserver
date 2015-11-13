#!/usr/bin/env bash

SYSTEMS="chefserver work node"
IPADDRESS=6

for SYSTEM in ${SYSTEMS}; do
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

  ### CREATE HOSTS
  grep -q -F ${SYSTEM} /etc/hosts || echo "192.168.50.${IPADDRESS} ${SYSTEM}" >> /etc/hosts
  ((IPADDRESS++))
done
