# NOTE: THIS IS RUN ON HOST SYSTEM
#  This package works for Ubuntu 10.04, 12.04, 14.04
$PACKAGE     = "chef-server-core_12.3.0-1_amd64.deb"
$PACKAGE_URL = "https://packagecloud.io/chef/stable/packages/ubuntu/trusty/${PACKAGE}/download"

(New-Object System.Net.WebClient).DownloadString("$PACKAGE_URL") > "$PACKAGE"
