#!/bin/bash

cd $HOME
git clone https://github.com/apuignav/dotfiles.git
cd dotfiles
git submodule update --init --recursive dotbot
git submodule update --init --recursive deploy/dotbot-brew
echo "Ready to install"
