#!/usr/bin/env python
# -*- coding: utf-8 -*-
# =============================================================================
# @file   config.py
# @author Albert Puig (albert.puig@cern.ch)
# @date   30.06.2015
# =============================================================================
"""Prepare the dotfiles deployment."""

import os
import subprocess
import shutil
import argparse


DOTFILES_DIR = os.path.abspath(os.path.expandvars("$HOME/dotfiles"))
LOCAL_DIR = os.path.join(DOTFILES_DIR, 'local')
DOTBOT_DIR = os.path.join(DOTFILES_DIR, 'dotbot')


def run_command(cmd, *args):
    """Run given command with args on the command line.

    :param cmd: command to execute
    :type cmd: string
    :param args: arguments of the command
    :type args: list

    :return: list of lines of the output

    """
    process = subprocess.Popen([cmd]+list(args),
                               stdout=subprocess.PIPE,
                               stderr=subprocess.STDOUT)

    output = [line
              for line in process.communicate()[0].split('\n')
              if line]
    return (process.returncode, output)


def git(*args):
    """Execute a git command.

    If arguments with spaces are given, they are automatically split.

    """

    myargs = [element for arg in args for element in arg.split()]
    return run_command('git', *myargs)


def configure(ssh_folder):
    """Configure dotfile deployment.

    1. Copy the .ssh folder from the given folder.
    2. Clone the dotfiles repository, configure it.
    3. Clone the local git repository, update if necessary.
    4. Delete the .ssh folder, since it will be afterwards linked by dotbot.

    """
    # Copy the ssh folder
    if not os.path.isdir(ssh_folder):
        raise OSError("Cannot find ssh folder")
    shutil.copytree(ssh_folder, os.path.expandvars("$HOME/.ssh"))
    # Clone the dotfiles repository
    if not os.path.exists(DOTFILES_DIR):
        status, output = git("clone", "git@github.com:apuignav/dotfiles.git", DOTFILES_DIR)
        if status:
            print '\n'.join(output)
            raise OSError("Failed cloning/updated dotfiles git repo!")
    # Clone local git repo, update if necessary
    if not os.path.exists(LOCAL_DIR):
        status, _ = git("clone", "git@github.com:apuignav/dotfiles-local.git", os.path.join(DOTFILES_DIR, "local"))
        if status:
            raise OSError("Failed cloning/updated local git repo!")
        # Magic: fetch all remote branches and create trackingi local ones
        # http://stackoverflow.com/questions/67699/clone-all-remote-branches-with-git
        os.chdir(LOCAL_DIR)
        os.system(r"git branch -a |"
                  r"grep -v HEAD | "
                  r"perl -ne 'chomp($_); s|^\*?\s*||; if (m|(.+)/(.+)| && not $d{$2})"
                  r"{print qq(git branch --track $2 $1/$2\n)} else {$d{$_}=1}' "
                  r"| sh -xfs")
    os.chdir(LOCAL_DIR)
    git("pull --all")
    # Choose machine
    branches = [branch.replace('*', '').strip()
                for branch in git('branch')[1]
                if 'master' not in branch]
    machine = None
    while machine not in branches:
        machine = raw_input('Choose a machine [%s]: ' % (','.join(branches)))
    git("checkout", machine)
    os.chdir(DOTFILES_DIR)
    status, output = git("submodule update --init --recursive dotbot")
    if status:
        print '\n'.join(output)
        raise OSError("Problem pulling dotbot")
    shutil.rmtree(os.path.expandvars("$HOME/.ssh"))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("ssh_folder", action="store", type=str, help="Location of the ssh folder")
    args = parser.parse_args()
    configure(args.ssh_folder)
    print 'Install homebrew with -> ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'

# EOF
