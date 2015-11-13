#!/bin/sh
# NOTE: THIS IS RUN ON HOST SYSTEM
BUCKET=opscode-omnibus-packages.s3.amazonaws.com
PACKAGE=chefdk-0.10.0-1.el7.x86_64.rpm
PACKAGE_URL=https://${BUCKET}/el/7/x86_64/${PACKAGE}

# Copy to Downloads Folder (Ubuntu/Mac OS X)
[ -e ~/Downloads/${PACKAGE} ] || curl -o ~/Downloads/${PACKAGE} ${PACKAGE_URL}
# Copy Locally to make available to guest systems
[ -e ${PACKAGE} ] || cp -v ~/Downloads/${PACKAGE} ${PACKAGE}
