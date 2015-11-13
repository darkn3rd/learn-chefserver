#!/bin/sh

# Target Package
PACKAGE=chefdk-0.10.0-1.el7.x86_64.rpm

# Install Package If it Exists and not installed already
[ -f /vagrant/${PACKAGE} ] && rpm -q chefdk > /dev/null || sudo rpm -Uvh /vagrant/${PACKAGE}
