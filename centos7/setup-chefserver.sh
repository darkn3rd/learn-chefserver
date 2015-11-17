#!/bin/sh

# Target Package
PACKAGE=chef-server-core-12.3.0-1.el7.x86_64.rpm
PKGPATH=/vagrant/packages/${PACKAGE}

# Install Package if it is available and not installed already
[ -f ${PKGPATH} ] && rpm -q chef-server-core > /dev/null 2>&1 || sudo rpm -Uvh ${PKGPATH}

# Set SELinux to Permissive
[ "$(getenforce)" = "Permissive" ] || setenforce Permissive

# Disable Qpid
if $(rpm -qa | grep -q qpid); then
  echo "Chef Server Setup: Disabling QPid"
  service qpidd stop
  chkconfig --del qpidd
fi
