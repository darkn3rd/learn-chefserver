#!/bin/sh
# NAME: gen-databag-key.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-24
#
# PURPOSE: Generates a random key that can be used to encrypt data-bag secrets.
# DEPENDENCIES:
#  * Bourne Shell, POSIX command line tools (tr), openssl
# INSTRUCTIONS:
#  * generate a local password
#  * utilize the password when creating private data (passwords, keys, etc),
#     e.g. on the guest workstation:
#      `knife data bag create passwords`
#      `knife data bag from file passwords srv_psswd.json \
#         --secret-file /vagrant/.cofig/encrypted_data_bag_secret`
#  * install password into any client node,
#       e.g. `/etc/chef/encrypted_data_bag_secret`
#  * when creating recipes, reference location on the client,
#       e.g. `/etc/chef/encrypted_data_bag_secret`
# NOTES:
#  * This script can be run on the host system (Linux/OSX/CygWin) or guest
#    system (Ubuntu 14.04, CentOS 7)

##### Test for OpenSSL
[ -z $(which openssl) ] && { echo "ERROR: OpenSSL not found. Install openssl"; exit 1 ; }

##### Generate Secret Key
openssl rand -base64 512 | tr -d '\r\n' > encrypted_data_bag_secret
