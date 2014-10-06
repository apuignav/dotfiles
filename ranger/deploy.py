#!/usr/bin/env python

import os
import shutil
here = os.path.dirname( __file__ )

target = os.path.abspath(os.path.join(here, 'ranger'))
link_dir = os.path.expanduser(os.path.join('~', '.config'))
link = os.path.join(link_dir, 'ranger')
# Check config exists
if not os.path.exists(link_dir):
    os.mkdir(link_dir)
# Check link exists
if os.path.islink(link):
    if os.readlink(link) != target:
        os.unlink(link)
elif os.path.isdir(link):
    shutil.rmtree(link)
elif os.path.exists(link):
    os.unlink(link)
print "Linking %s -> %s" % (link, target)
os.symlink(target, link)

