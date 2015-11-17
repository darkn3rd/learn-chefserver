#!/bin/sh

# Target Package
PACKAGE=chefdk-0.10.0-1.el7.x86_64.rpm
PKGPATH=/vagrant/packages/${PACKAGE}

# Install Package If it Exists and not installed already
[ -f ${PKGPATH} ] && rpm -q chefdk > /dev/null 2>&1  || sudo rpm -Uvh ${PKGPATH}
