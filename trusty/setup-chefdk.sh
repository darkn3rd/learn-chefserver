#!/bin/sh
# Target Package
PACKAGE=chefdk_0.10.0-1_amd64.deb
PKGPATH=/vagrant/packages/${PACKAGE}

# Install Package If it Exists and not installed already
[ -f ${PKGPATH} ] && dpkg -s chefdk > /dev/null  2>&1 || dpkg -i ${PKGPATH}
