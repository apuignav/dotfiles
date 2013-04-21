#!/usr/bin/env python
# @file   deploy.py
# @author Albert Puig (albert.puig@epfl.ch)
# @date   25.03.2013

import os

def which(program):
    import os
    def is_exe(fpath):
        return os.path.isfile(fpath) and os.access(fpath, os.X_OK)

    fpath, fname = os.path.split(program)
    if fpath:
        if is_exe(program):
            return program
    else:
        for path in os.environ["PATH"].split(os.pathsep):
            path = path.strip('"')
            exe_file = os.path.join(path, program)
            if is_exe(exe_file):
                return exe_file

    return None

if os.uname()[0] == 'Darwin':
    commands = ['chflags nohidden /Users/albert/Library', 'defaults write com.apple.desktopservices DSDontWriteNetworkStores true']
    brewPackages = ['gfortran', 'python', 'ssh-copy-id', 'cmake', 'git', 'gsl', 'readline', 'tmux', 'wget', 'glib', 'gettext', 'ctags']

    for command in commands:
        os.system(command)

    if not which('brew'): # Need to install homebrew!
        os.system('ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"')
        os.system('brew install {0}'.format(' '.join(brewPackages)))
        # Install macvim
        os.system("""cd /System/Library/Frameworks/Python.framework/Versions &&
                    sudo mv Current Current-sys &&
                    sudo ln -s /usr/local/Cellar/python/2.7.4/Frameworks/Python.framework/Versions/2.7 Current &&
                    brew install macvim &&
                    sudo mv Current Current-brew &&
                    sudo mv Current-sys Current""")
        os.system("ln -s /usr/local/bin/mvim /usr/local/bin/vi")


# EOF
