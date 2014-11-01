#!/bin/bash 

casks=$(<casks.txt)

# Open casks!
for app in "${casks[@]}"
do
    brew cask install $app --appdir=/Applications
done

# And the fonts!
fonts=$(<fonts.txt)

for font in "${fonts[@]}"
do
    brew cask install $font
done

# EOF