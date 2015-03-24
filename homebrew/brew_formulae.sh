#!/bin/bash

formulae=$(<formulae.txt)
brew update

# Install requirement
brew cask install xquartz --appdir=/Applications

# Install
for app in "${formulae[@]}"
do
    brew install $app
done

# Now it's MacVim time
python_loc=$(brew info python | grep Cellar | awk '{print $1}')
brew remove macvim
cd /System/Library/Frameworks/Python.framework/Versions && sudo mv Current Current-sys && sudo ln -sf ${python_loc}/Frameworks/Python.framework/Versions/2.7 Current && brew install macvim --override-system-vim --with-lua && sudo mv Current Current-brew && sudo mv Current-sys Current
cd -
