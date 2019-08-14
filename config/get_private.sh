#!/bin/bash

set -e

if [ ! -f "$HOME/dotfiles/config/photo_config.yaml" ]; then
    mytmpdir=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
    cwd=$PWD
    cd $mytmpdir
    # To encode: gpg --output photo_config.yaml.enc --symmetric --cipher-algo AES256 photo_config.yaml
    curl -L -o photo_config.yaml.enc "https://www.dropbox.com/s/jghjly9r246zwex/photo_config.yaml.enc?dl=1"
    gpg --output photo_config.yaml --decrypt photo_config.yaml.enc
    cp photo_config.yaml $HOME/dotfiles/config/photo_config.yaml
    cd $cwd
    rm -rf $mytmpdir
fi
