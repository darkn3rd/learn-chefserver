#!/usr/bin/env bash
# NAME: setup-base.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
# UPDATED:
#   * 2016-08-05 adopted by learn-chef project using host name
#
# PURPOSE: Configures `/etc/hosts` and global ssh configuration for each
#  password-less system to system communication through ssh.
# DEPENDENCIES:
#  * baselib.src
# NOTES:
#  * This script will be run on the guest operating system

##### Variables
CONFIGFILE=${VAGRANT_CONFIG:-"/vagrant/config/default.hosts"}
SCRIPTDIR="/vagrant/scripts"
SCRIPTLIB="${SCRIPTDIR}/libs"

##### Verify Configuration Exists
[ -e ${CONFIGFILE} ] || \
  { echo "ERROR: ${CONFIGFILE} doesn't exist. Exiting"; exit 1; }

##### Source Base Library
#[ "${0:0:1}" = "/" ] && SCRIPTDIR="${0%/*}" || SCRIPTDIR="${PWD}/${0%/*}"
. ${SCRIPTLIB}/provision.src

##### Setup /etc/ssh_config and /etc/hosts
config_ssh ${CONFIGFILE}
config_hosts ${CONFIGFILE}
install_utilities
