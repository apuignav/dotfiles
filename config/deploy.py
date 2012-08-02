#!/usr/bin/env python

import os
import shutil
here = os.path.dirname( __file__ )

def getSystemType():
  return os.uname()[0]


for link, target in ( ( ".aliases", os.path.join( here, "aliases_" + getSystemType()  ) ), ( ".paths", os.path.join( here, "paths_" +
  getSystemType()) ) ):
  target = os.path.realpath( target )
  link = os.path.expanduser( os.path.join( "~", link ) ) 
  if os.path.exists( link ):
    if os.path.islink( link ):
      if os.readlink( link ) == target:
        continue
    if os.path.isdir( link ):
      shutil.rmtree( link )
    else:
      os.unlink( link )
  print "Linking %s -> %s" % ( link, target )
  os.symlink( target, link )

for link, target in ( ( ".latex.mk", os.path.join( here, "latex.mk" ) ), ( ".functions", os.path.join( here, "functions" ) ) ):
  target = os.path.realpath( target )
  link = os.path.expanduser( os.path.join( "~", link ) ) 
  if os.path.exists( link ):
    if os.path.islink( link ):
      if os.readlink( link ) == target:
        continue
    else:
      if os.path.isdir( link ):
        shutil.rmtree( link )
      else:
        os.unlink( link )
      print "Linking %s -> %s" % ( link, target )
      os.symlink( target, link )

