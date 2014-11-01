#!/bin/bash

if [ ! -d "$HOME/.vim/bundle/vundle" ]; then
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
    vim +PluginInstall +qall
else
    vim +PluginUpdate +qall
fi

# EOF