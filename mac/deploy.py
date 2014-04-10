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
    commands = ['chflags nohidden /Users/albert/Library',
                'defaults write com.apple.desktopservices DSDontWriteNetworkStores true']
    brewPackages = [# Compiling libraries
                    'glib',
                    'gfortran',
                    'cairo',
                    'cmake',
                    'rubber',
                    'vala',
                    'yasm',
                    'autoconf',
                    'automake',
                    'llvm',
                    'lua',
                    'readline',
                    # Python
                    'python',
                    # Utils
                    'ack',
                    'git',
                    'git-extras',
                    'gettext',
                    'ssh-copy-id',
                    # The rest, in no particular order
                    'boost',
                    'cloog',
                    'cscope',
                    'ctags',
                    'faac',
                    'ffmpeg',
                    'fftw',
                    'flac',
                    'fontconfig',
                    'fontforge',
                    'freetype',
                    'gd',
                    'gdbm',
                    'ghostscript',
                    'gmp',
                    'gnuplot',
                    'graphviz',
                    'gsl',
                    'harfbuzz',
                    'hub',
                    'icu4c',
                    'imagemagick',
                    'imagesnap',
                    'intltool',
                    'isl',
                    'jasper',
                    'jbig2dec',
                    'jpeg',
                    'lame',
                    'lcdf-typetools',
                    'libebml',
                    'libevent',
                    'libffi',
                    'libmagic',
                    'libmatroska',
                    'libmpc',
                    'libogg',
                    'libpng',
                    'libtiff',
                    'libtool',
                    'libvorbis',
                    'libyaml',
                    'little-cms',
                    'little-cms2',
                    'lzo',
                    'mkvtoolnix',
                    'mpfr',
                    'netpbm',
                    'pango',
                    'pcre',
                    'pixman',
                    'pkg-config',
                    'potrace',
                    'rbenv',
                    'root',
                    'sqlite',
                    'texi2html',
                    'tmux',
                    'wget',
                    'x264',
                    'xvid',
                    'xz']

    for command in commands:
        os.system(command)

    if not which('brew'): # Need to install homebrew!
        os.system('ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"')
        os.system('brew tap homebrew/science')
        os.system('brew tap homebrew/dupes')
        for package in brewPackages:
            os.system('brew install %s' % package)
        # Install macvim
        os.system("""cd /System/Library/Frameworks/Python.framework/Versions &&
                    sudo mv Current Current-sys &&
                    sudo ln -s /usr/local/Cellar/python/2.7.5/Frameworks/Python.framework/Versions/2.7 Current &&
                    brew install macvim &&
                    sudo mv Current Current-brew &&
                    sudo mv Current-sys Current""")
        os.system("ln -s /usr/local/bin/mvim /usr/local/bin/vi")
        os.system("sudo ln -s /usr/X11/include/freetype2/freetype /usr/X11/include/.")

    # Git
    os.system('git config --global push.default "Simple"')


# EOF
