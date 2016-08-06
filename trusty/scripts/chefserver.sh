#!/bin/sh

PKG_PATH="/vagrant/packages"
PKG_MANIFEST="/vagrant/config/packages.csv"
SCRIPTDIR="/vagrant/scripts"
SCRIPTLIB="${SCRIPTDIR}/libs"

. ${SCRIPTLIB}/chefserver.src

./setup-base.sh

fetch_chefserver
install_chefserver
config_chefserver
