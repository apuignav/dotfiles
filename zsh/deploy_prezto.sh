#!/bin/bash

if [ ! -d "$HOME/.zprezto" ]; then
    GIT_SSL_NO_VERIFY=true
    git clone --recursive https://github.com/sorin-ionescu/prezto.git $HOME/.zprezto
else
    olddir=$PWD
    cd $HOME/.zprezto
    git pull && git submodule update --init --recursive
    cd $olddir
fi

# EOF
