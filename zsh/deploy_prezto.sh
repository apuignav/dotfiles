#!/bin/bash

if [ ! -d "$HOME/.prezto" ]; then
    GIT_SSL_NO_VERIFY=true
    git clone --recursive https://github.com/sorin-ionescu/prezto.git $HOME/.prezto
fi

# EOF
