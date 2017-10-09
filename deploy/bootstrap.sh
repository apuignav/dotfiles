#!/bin/bash

cd $HOME
git clone https://github.com/apuignav/dotfiles.git
cd dotfiles
git submodule update --init --recursive dotbot
echo "Ready to install"
