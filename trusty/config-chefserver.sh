#!/bin/sh

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

## MANAGEMENT CONSOLE
chef-server-ctl install opscode-manage
chef-server-ctl reconfigure
opscode-manage-ctl reconfigure

## REPORTING FEATURE
chef-server-ctl install opscode-reporting
chef-server-ctl reconfigure
opscode-reporting-ctl reconfigure

## ADMINISTRATION ACCOUNT
ADMIN_USER_NAME="vagrant"
ADMIN_FIRST_NAME="vagrant"
ADMIN_LAST_NAME="vagrant"
ADMIN_EMAIL="vagrant@chefserver.dev"
ADMIN_PASSWORD="vagrant"

chef-server-ctl user-create ${ADMIN_USER_NAME} ${ADMIN_FIRST_NAME} ${ADMIN_LAST_NAME} ${ADMIN_EMAIL} ${ADMIN_PASSWORD} --filename ${ADMIN_USER_NAME}.pem
cp -v ${ADMIN_USER_NAME}.pem /vagrant/chef-repo/.chef

### ORGANITATION
ORG_LONG_NAME="Vagrant Development Team"
ORG_SHORT_NAME="vagrantdev"
ORG_ASSOC_USER="vagrant"

sudo chef-server-ctl org-create ${ORG_SHORT_NAME} ${ORG_LONG_NAME} --association_user ${ORG_ASSOC_USER} -f ${ORG_SHORT_NAME}-validator.pem
cp -v ${ORG_SHORT_NAME}-validator.pem /vagrant/chef-repo/.chef
