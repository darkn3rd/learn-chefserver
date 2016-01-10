#!/bin/sh
# NAME: config-node.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-24
#
# PURPOSE: Configures Chef Node with opetioanl secret key
# DEPENDENCIES:
#  * Chef Client Previously Installed
# NOTES:
#  * This script will be run on the guest operating system

CONFIG="/vagrant/.config"
SECRET=${CONFIG}/encrypted_data_bag_secret

#### Copy secret file if it exists
if [ -e ${SECRET} ]; then
   mkdir -vp /etc/chef
   cp -v ${SECRET} /etc/chef
fi
