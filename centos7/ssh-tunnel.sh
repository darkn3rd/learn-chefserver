#!/bin/sh

IDENTITY_FILE=$(vagrant ssh-config chefserver | grep -o '\/.*chefserver.*')
PORT=$(vagrant ssh-config chefserver | grep -oE '[0-9]{4,5}')

### NORMAL LOG IN PROCESS
# ssh -p ${PORT} -i ${IDENTIFY_FILE} vagrant@localhost

### SETUP A TUNNEL
sudo ssh -f -N -L 443:localhost:443 vagrant@localhost -p ${PORT} -i ${IDENTITY_FILE}
