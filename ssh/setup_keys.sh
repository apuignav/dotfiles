#!/bin/bash

if [ ! -f "$HOME/.ssh/id_dsa" ]; then
    mytmpdir=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
    cwd=$PWD
    cd $mytmpdir
    wget -O keys.zip.gpg "https://www.dropbox.com/s/hddmaounmfdm3d9/keys.zip.gpg?dl=0"
    gpg -d keys.zip.gpg > keys.zip
    unzip keys.zip

    if [ -f "$HOME/.ssh/id_dsa.pub" ]; then
        rm $HOME/.ssh/id_dsa.pub
    fi
    cp albert/id_dsa $HOME/.ssh/id_dsa
    cp albert/id_dsa.pub $HOME/.ssh/id_dsa.pub
    cd $cwd
    rm -rf $mytmpdir
fi
