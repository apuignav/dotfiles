!/bin/bash

if [ ! -f "$HOME/.ssh/id_rsa" ]; then
    mytmpdir=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
    cwd=$PWD
    cd $mytmpdir
    # To encode: openssl des -in keys.zip -out keys.zip.enc
    curl -o keys.zip.gpg "https://www.dropbox.com/s/cehx46pn6a5qb25/keys.zip.enc?dl=0"
    openssl des -d -in keys.zip.enc -out keys.zip
    unzip keys.zip

    if [ -f "$HOME/.ssh/id_rsa.pub" ]; then
        rm $HOME/.ssh/id_rsa.pub
    fi
    cp id_rsa $HOME/.ssh/id_rsa
    cp id_rsa.pub $HOME/.ssh/id_rsa.pub
    cd $cwd
    rm -rf $mytmpdir
fi
