#!/bin/sh
# NAME: config-chefserver.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
#
# PURPOSE: Configures installed Chef Server and installs reporting and
#  management console, configures administration accounds, and generates
#  private keys.
# DEPENDENCIES:
#  * Chef Server Package installed
#  * Global Configuration (optional) - JSON.sh, global.json
# NOTES:
#  * This script will be run on the guest operating system

# INITIAL CONFIGURATION
cat <<-CHEFSRVR_EOF > /etc/opscode/chef-server.rb
server_name = "chefserver"
api_fqdn server_name
bookshelf['vip'] = server_name
nginx['url'] = "https://#{server_name}"
nginx['server_name'] = server_name
nginx['ssl_certificate'] = "/var/opt/opscode/nginx/ca/#{server_name}.crt"
nginx['ssl_certificate_key'] = "/var/opt/opscode/nginx/ca/#{server_name}.key"
CHEFSRVR_EOF

chef-server-ctl reconfigure

## CONFIG DIRECTORIES
CONFIG="/vagrant/.config"
PKGDIR=/vagrant/packages

## MANAGEMENT CONSOLE
JSON_DATA=$($CONFIG/JSON.sh -l < $CONFIG/global.json | grep '"manage"')
PACKAGE=$(echo "${JSON_DATA}" | grep '"package"' | awk '{ print $2 }' | tr -d '"')
# install from local package source or from Internet
if [ -f "${PKGDIR}/${PACKAGE}" ]; then
  chef-server-ctl install opscode-manage --path ${PKGDIR}
else
  chef-server-ctl install opscode-manage
fi

chef-server-ctl reconfigure
opscode-manage-ctl reconfigure

## REPORTING FEATURE
JSON_DATA=$($CONFIG/JSON.sh -l < $CONFIG/global.json | grep '"reporting"')
PACKAGE=$(echo "${JSON_DATA}" | grep '"package"' | awk '{ print $2 }' | tr -d '"')
# install from local package source or from Internet
if [ -f "${PKGDIR}/${PACKAGE}" ]; then
  chef-server-ctl install opscode-reporting --path ${PKGDIR}
else
  chef-server-ctl install opscode-reporting
fi
chef-server-ctl reconfigure
opscode-reporting-ctl reconfigure

## ADMINISTRATION ACCOUNT
ADMIN_USER_NAME="vagrant"
ADMIN_FIRST_NAME="vagrant"
ADMIN_LAST_NAME="vagrant"
ADMIN_EMAIL="vagrant@chefserver.dev"
ADMIN_PASSWORD="vagrant"

chef-server-ctl user-create ${ADMIN_USER_NAME} ${ADMIN_FIRST_NAME} ${ADMIN_LAST_NAME} ${ADMIN_EMAIL} ${ADMIN_PASSWORD} --filename ${ADMIN_USER_NAME}.pem
cp -v ${ADMIN_USER_NAME}.pem /vagrant/.chef

### ORGANITATION
ORG_LONG_NAME="Vagrant Development Team"
ORG_SHORT_NAME="vagrantdev"
ORG_ASSOC_USER="vagrant"

sudo chef-server-ctl org-create ${ORG_SHORT_NAME} ${ORG_LONG_NAME} --association_user ${ORG_ASSOC_USER} -f ${ORG_SHORT_NAME}-validator.pem
cp -v ${ORG_SHORT_NAME}-validator.pem /vagrant/.chef
