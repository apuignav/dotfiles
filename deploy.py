#!/usr/bin/env python
# -*- coding: utf-8 -*-
# =============================================================================
# @file   deploy.py
# @author Albert Puig (albert.puig@cern.ch)
# @date   31.10.2014
# =============================================================================
"""Deploy dotfiles."""

import os
import shutil
import logging

import platform
import subprocess
from contextlib import contextmanager

#############
#  Logging  #
#############

logging.basicConfig(level=logging.INFO)

####################
#  Host functions  #
####################

def is_mac():
    """Is this machine a Mac?

    :rtype: bool

    """
    return 'Darwin' in platform.platform()

#############
#  Helpers  #
#############

def which(command):
    """Get location of a command.

    :param command: Command to look for.
    :type command: str

    :returns: Command location

    """
    def is_exe(path):
        """Is executable?

        :param path: Path to check.
        :type path: str

        :rtype: bool

        """
        return os.path.isfile(path) and os.access(path, os.X_OK)

    command_path, _ = os.path.split(command)
    if command_path:
        if is_exe(command):
            return command
    else:
        for path in os.environ["PATH"].split(os.pathsep):
            path = path.strip('"')
            exe_file = os.path.join(path, command)
            if is_exe(exe_file):
                return exe_file
    return None


def mkdir(path):
    """Make dir.

    :param path: Path to make.
    :type path: str

    """
    path = os.path.abspath(os.path.expandvars(os.path.expanduser(path)))
    if not os.path.isdir(path):
        os.mkdir(path)

#############
#  Actions  #
#############

@contextmanager
def cd(path):
    """Context manager for cd.

    :param path: Path to cd into.
    :type path: str

    """
    prev_cwd = os.getcwd()
    os.chdir(path)
    try:
        yield
    finally:
        os.chdir(prev_cwd)


def symlink(origin, destination):
    """Create symbolic link.

    :param origin: Source of link.
    :type origin: str
    :param destination: Destination of link
    :type destination: str

    """
    origin = os.path.abspath(origin)
    destination = os.path.abspath(os.path.expandvars(os.path.expanduser(destination)))
    logging.debug("Requested symlink from %s to %s", origin, destination)
    if os.path.islink(destination):
        if origin == os.readlink(destination):
            logging.info("Link %s -> %s already set up", origin, destination)
            return
    if os.path.exists(destination):
        os.unlink(destination)
    logging.info("Linking %s -> %s", origin, destination)
    os.symlink(origin, destination)


def copy(origin, destination):
    """Copy file.

    The file is copied only if the destination doesn't exist.

    :param origin: Source file.
    :type origin: str
    :param destination: Destination file
    :type destination: str

    """
    origin = os.path.abspath(origin)
    destination = os.path.abspath(os.path.expandvars(os.path.expanduser(destination)))
    logging.debug("Requested copy from %s to %s", origin, destination)
    if not os.path.exists(destination):
        logging.info("Copying %s -> %s", origin, destination)
        shutil.copy(origin, destination)


def execute(command, get_output=False):
    """Execute command.

    :param command: Command to execute.
    :type command: str
    :param get_output: Get the output?
    :type: bool

    :returns: Lines of output (if requested)
    :rtype: list

    """
    logging.info("Executing '%s'", command)
    if get_output:
        return [line for line in subprocess.Popen(command.split(),
                                                  stdout=subprocess.PIPE,
                                                  stderr=subprocess.STDOUT).communicate()[0].split('\n')
                if line]
    else:
        os.system(command)
        return


install_bash = False

# TODO: mackup

if __name__ == '__main__':
    logging.info("Welcome to the deploy script. Fasten your seatbelt!")
    # First, let's make a dir
    mkdir('$HOME/.local')
    # Now let's work
    if is_mac():
        with cd('homebrew'):
            # Install brew
            if not which('brew'):
                logging.info("Installing homebrew")
                execute('./install.sh')
            # Now brew!
            logging.info("Brewing, this may take a while...")
            execute('./brew_formulae.sh')
            logging.info("Opening casks, please wait...")
            execute('./open_casks.sh')
    else:  # Assume Linux without sudo
        # Install pip and ranger
        pass

    with cd('zsh'):
        execute('./deploy_prezto.sh')
        for zfile in ['zlogin', 'zlogout', 'zpreztorc', 'zprofile', 'zshrc']:
            symlink(zfile, '$HOME/.%s' % zfile)
        symlink('prompt/prompt_apuignav_setup',
                '$HOME/.zprezto/modules/prompt/functions/prompt_apuignav_setup')
        system = 'Darwin' if is_mac() else 'Linux'
        with cd(system):
            symlink('paths', '$HOME/.paths')
            symlink('aliases', '$HOME/.aliases')

    if install_bash:
        with cd('bash'):
            for bfile in ['bash_profile', 'common', 'functions', 'mybash']:
                symlink(bfile, '$HOME/.%s' % bfile)

    with cd('hosts'):
        if is_mac():
            with cd('mac'):
                symlink('localrc', '$HOME/.localrc')
                execute('./defaults.sh')
        elif 'el6' in execute('uname -r', True)[0]:
            with cd('slc6'):
                symlink('localrc', '$HOME/.localrc')
                symlink('vimrc.local', '$HOME/.vimrc.local')
        elif which('cernvm-update'):
            with cd('cernvm'):
                symlink('localrc', '$HOME/.localrc')

    with cd('python'):
        execute('pip install --upgrade -r pip_packages.txt')
        for pyfile in ['pylintrc', 'pythonrc', 'percol.d']:
            symlink(pyfile, '$HOME/.%s' % pyfile)

    with cd('git'):
        symlink('gitignore_global', '$HOME/.gitignore_global')
        copy('gitconfig', '$HOME/.gitconfig')
        # execute("git config --global color.ui true")
        # execute('git config --global author.name "Albert Puig"')
        # execute('git config --global author.email "albert.puig@cern.ch"')
        # execute('git config --global push.default simple')
        # execute('git config --global core.excludesfile ~/.gitignore_global')

    with cd('ssh'):
        symlink('ssh', '$HOME/.ssh')
        execute('./setup_keys.sh')
        execute('./fix_permissions.sh')

    with cd('vim'):
        symlink('vim', '$HOME/.vim')
        symlink('vimrc', '$HOME/.vimrc')
        symlink('gvimrc', '$HOME/.gvimrc')
        execute('./install_plug.sh')

    with cd('scripts'):
        symlink('bin', '$HOME/.scripts')

    with cd('config'):
        # Ballast
        symlink('ballast.conf', '$HOME/.ballast.conf')
        # Tmux
        symlink('tmux.conf', '$HOME/.tmux.conf')

    # Passpie
    symlink('$HOME/Dropbox/Backup/Security/.passpie', '$HOME/.passpie')

# EOF
