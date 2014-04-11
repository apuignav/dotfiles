#!/usr/bin/env python

import os
import shutil
here = os.path.dirname( __file__ )

def getSystemType():
    return os.uname()[0]

things_to_link = ( ( ".aliases", os.path.join( here, "aliases_" + getSystemType()  ) ),
                   ( ".paths", os.path.join( here, "paths_" + getSystemType()) ),
                   ( ".common", os.path.join( here, "common" ) ),
                   ( ".functions", os.path.join( here, "functions" ) ),
                   #( ".latex.mk", os.path.join( here, "latex.mk" ) ),
                 )

for link, target in things_to_link:
    target = os.path.realpath( target )
    link = os.path.expanduser( os.path.join( "~", link ) )
    if os.path.islink( link ):
        if os.readlink( link ) == target:
            continue
        else:
            os.unlink( link )
    if os.path.isdir( link ):
        shutil.rmtree( link )
    elif os.path.exists( link ):
        os.unlink( link )
    print "Linking %s -> %s" % ( link, target )
    os.symlink( target, link )

if getSystemType() == 'Darwin':
    os.system("defaults write com.apple.Dock showhidden -bool YES && killall Dock")

