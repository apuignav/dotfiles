#!/bin/bash

if [ ! -f "$HOME/.ssh/id_dsa" ]; then
    cd $TMPDIR
    wget -O keys.zip.gpg "https://www.dropbox.com/s/y11x0abb2uwpu8c/keys.zip.gpg?dl=0"
    gpg -d keys.zip.gpg > keys.zip
    unzip keys.zip

    if [ -f "$HOME/.ssh/id_dsa.pub" ]; then
        rm $HOME/.ssh/id_dsa.pub
    fi
    cp albert/id_dsa $HOME/.ssh/id_dsa
    cp albert/id_dsa.pub $HOME/.ssh/id_dsa.pub
fi
