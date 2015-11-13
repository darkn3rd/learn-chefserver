#!/bin/sh

# Target Package
PACKAGE=chef-server-core-12.3.0-1.el7.x86_64.rpm

# Install Package if it is available and not installed already
[ -f /vagrant/${PACKAGE} ] && rpm -q chef-server-core > /dev/null || sudo rpm -Uvh /vagrant/${PACKAGE}

# Set SELinux to Permissive
[ "$(getenforce)" = "Permissive" ] || setenforce Permissive

# Disable Qpid
if $(rpm -qa | grep -q qpid); then
  service qpidd stop
  chkconfig --del qpidd
fi
