#!/usr/bin/env zsh

# Check if mvim exists and use it
if (( $+commands[mvim] )) ; then
    prog=mvim
else
    prog=vim
fi

# Install plug if not there
if [ ! -e ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install and upgrade plugins
if [ ! -d "$HOME/.vim/plugged" ]; then
    $prog +PlugInstall
else
    $prog +PlugUpgrade +PlugInstall +PlugUpdate +q +q
fi

# Initialize spelling
$prog "+mkspell! ~/.vim/spell/en.utf-8.add" +q

# EOF