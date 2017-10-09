https://www.dropbox.com/s/hddmaounmfdm3d9/keys.zip.gpg?dl=0#!/bin/bash

if [ ! -f "$HOME/.ssh/id_rsa" ]; then
    mytmpdir=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
    cwd=$PWD
    cd $mytmpdir
    curl -o keys.zip.gpg "https://www.dropbox.com/s/hddmaounmfdm3d9/keys.zip.gpg?dl=0"
    gpg -d keys.zip.gpg > keys.zip
    unzip keys.zip

    if [ -f "$HOME/.ssh/id_rsa.pub" ]; then
        rm $HOME/.ssh/id_rsa.pub
    fi
    cp id_rsa $HOME/.ssh/id_rsa
    cp id_rsa.pub $HOME/.ssh/id_rsa.pub
    cd $cwd
    rm -rf $mytmpdir
fi
