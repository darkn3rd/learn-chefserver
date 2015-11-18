# NOTE: THIS IS RUN ON HOST SYSTEM
$BUCKET="opscode-omnibus-packages.s3.amazonaws.com"
$PACKAGE="chefdk-0.10.0-1.el7.x86_64.rpm"
$PACKAGE_URL="https://$($BUCKET)/el/7/x86_64/$($PACKAGE)"

if (-Not $(Test-Path $PACKAGE)) {
  (New-Object System.Net.WebClient).DownloadString("$PACKAGE_URL") > "$PACKAGE"
}
