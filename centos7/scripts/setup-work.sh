#!/bin/sh
# NAME: setup-work.sh
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
#
# PURPOSE: Install tools (tree, curl, unzip, vim) and basic colorized vim
#  configuration.
# DEPENDENCIES:
#  * Updated package links
#  * POSIX Shell
# NOTES:
#  * This script will be run on the guest operating system

# Packages Used in Demo
yum install -y tree curl unzip vim

# Enable Color Syntax Highlighting
cat <<-VIMRC_EOF > /home/vagrant/.vimrc
filetype plugin indent on
syntax on
colorscheme delek
VIMRC_EOF
