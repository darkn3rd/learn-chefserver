#!/bin/sh
# NOTE: THIS IS RUN ON HOST SYSTEM
BUCKET=opscode-omnibus-packages.s3.amazonaws.com
PACKAGE=chefdk_0.10.0-1_amd64.deb
PACKAGE_URL=https://${BUCKET}/ubuntu/12.04/x86_64/${PACKAGE}

# Download Locally
[ -e ${PACKAGE} ] || curl -o ${PACKAGE} ${PACKAGE_URL}
