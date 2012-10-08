#!/usr/bin/env python

import sys, os

here = os.path.dirname( os.path.realpath( __file__ ) )

omzDir = os.path.expanduser( os.path.join( "~" , ".oh-my-zsh" ) )
if os.path.isdir( omzDir ):
  print "Seems oh-my-zsh is already installed in %s" % omzDir
else:
  os.environ[ "GIT_SSL_NO_VERIFY"] = "true"

  if os.system( "git clone https://github.com/apuignav/oh-my-zsh.git %s" % omzDir ) != 0:
    print "Cound not clone oh-my-zsh into %s" % omzDir
    sys.exit( 1 )

  if os.system( "cd %s; git submodule update --init --recursive" % omzDir ) != 0:
    print "Could not initialize OMZ submodules"
    sys.exit( 1 )

