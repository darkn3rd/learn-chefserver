#!/bin/sh

# Target Package
PACKAGE=chefdk_0.9.0-1_amd64.deb

# Install Package If it Exists and not installed already
[ -f /vagrant/${PACKAGE} ] && dpkg -s chefdk > /dev/null || dpkg -i /vagrant/${PACKAGE}
