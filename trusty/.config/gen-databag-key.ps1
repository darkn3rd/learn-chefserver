# NAME: gen-databag-key.ps1
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-24
#
# PURPOSE: Generates a random key that can be used to encrypt data-bag secrets.
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
#  * This script can be run on the host system (Windows NT 6.1+) with
#  PowerSHell 1.0

##### Generate Secret Key
$key = New-Object byte[](512)
$rng = [System.Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($key)
[Convert]::ToBase64String($key) | Out-File "encrypted_data_bag_secret" -encoding "UTF8"[array]::Clear($key, 0, $key.Length)
