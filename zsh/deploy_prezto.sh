#!/bin/bash

if [ ! -d "$HOME/.prezto" ]; then
    GIT_SSL_NO_VERIFY=true
    git clone --recursive https://github.com/sorin-ionescu/prezto.git $HOME/.prezto
else
    olddir=$PWD
    cd $HOME/.prezto
    git pull && git submodule update --init --recursive
    cd $olddir
fi

# EOF
