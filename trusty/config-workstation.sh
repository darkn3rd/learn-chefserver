#!/bin/sh

# COPY CHEF-REPO w/ KEYS
su vagrant -c 'cp -r /vagrant/chef-repo ~vagrant'
# INSTALL KEY INTO TRUSTED KEY AREA
su vagrant -c 'cd ~vagrant/chef-repo; knife ssl fetch'
