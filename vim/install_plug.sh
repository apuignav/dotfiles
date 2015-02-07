#!/bin/bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if [ ! -d "$HOME/.vim/plugged" ]; then
    vim +PlugInstall
else
    vim +PlugUpdate
fi

# EOF