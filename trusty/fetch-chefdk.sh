#!/bin/sh
# NOTE: THIS IS RUN ON HOST SYSTEM
BUCKET=opscode-omnibus-packages.s3.amazonaws.com
PACKAGE=chefdk_0.9.0-1_amd64.deb
UBUNTU_URL=https://${BUCKET}/ubuntu/12.04/x86_64/${PACKAGE}

# Copy to Downloads Folder (Ubuntu/Mac OS X)
[ -e ~/Downloads/${PACKAGE} ] || curl -o ~/Downloads/${PACKAGE} ${UBUNTU_URL}
# Copy Locally to make available to guest systems
[ -e ${PACKAGE} ] || cp -v ~/Downloads/${PACKAGE} ${PACKAGE}
