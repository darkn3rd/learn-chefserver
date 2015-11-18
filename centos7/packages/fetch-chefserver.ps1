# NOTE: THIS IS RUN ON HOST SYSTEM
#  This package works for CentOS 7 or RHEL 7
$PACKAGE     = "chef-server-core-12.3.0-1.el7.x86_64.rpm"
$PACKAGE_URL = "https://packagecloud.io/chef/stable/packages/el/7/$PACKAGE/download"

(New-Object System.Net.WebClient).DownloadString("$PACKAGE_URL") > "$PACKAGE"
