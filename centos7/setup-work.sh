#!/bin/sh

# Packages Used in Demo
yum install -y tree curl unzip vim

# Enable Color Syntax Highlighting
cat <<-VIMRC_EOF > /home/vagrant/.vimrc
filetype plugin indent on
syntax on
colorscheme delek
VIMRC_EOF