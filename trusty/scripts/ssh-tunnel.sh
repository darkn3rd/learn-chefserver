#!/bin/sh
# NAME: ssh-tunnel.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
#
# PURPOSE: Creates SSH Tunnel to the Chef Server, so afterwards with your Web
#  browser you can access Chef Server by https://127.0.0.1 wtih vagrant/vagrant
#  as user-name/password
# DEPENDENCIES:
#  * POSIX Shell
#  * OpenSSH (on host)
#  * Vagrant with provisioned Chef Server guest
#  * Root/Administrative password, ability to escalate priviledges
# NOTES:
#  * This script will be run on host (Linux/OS X)
#  * This has NOT been tested on Windows with either WinSSHD or CygWin

cd ..
IDENTITY_FILE=$(vagrant ssh-config chefserver | grep -o '\/.*chefserver.*')
PORT=$(vagrant ssh-config chefserver | grep -oE '[0-9]{4,5}')

### Normal Log on process with `vagrant ssh chefserver`
# ssh -p ${PORT} -i ${IDENTIFY_FILE} vagrant@localhost

### CONFIGURE A BACKGROUND TUNNEL
sudo ssh -f -N -L 443:localhost:443 vagrant@localhost -p ${PORT} -i ${IDENTITY_FILE}
