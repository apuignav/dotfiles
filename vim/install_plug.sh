#!/bin/bash

# Install plug if not there
if [ ! -e ~/.vim/autoload/plug.vim ]; then
    echo "Hi"
    # curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install and upgrade  plugins
if [ ! -d "$HOME/.vim/plugged" ]; then
    vim +PlugInstall
else
    vim +PlugUpgrade +PlugInstall +PlugUpdate +q +q
fi

# EOF