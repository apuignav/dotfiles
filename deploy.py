#!/usr/bin/env python
# -*- coding: utf-8 -*-
# =============================================================================
# @file   deploy.py
# @author Albert Puig (albert.puig@cern.ch)
# @date   30.06.2015
# =============================================================================
"""Deploy my dotfiles with dotbot."""

import os
import subprocess


DOTFILES_DIR = os.path.abspath(os.path.expandvars("$HOME/dotfiles"))
LOCAL_DIR = os.path.join(DOTFILES_DIR, 'local')
DOTBOT_DIR = os.path.join(DOTFILES_DIR, 'dotbot')
CURRENT_DIR = os.getcwd()


class DotbotError(Exception):
    """Error in deployment with dotbot."""
    pass


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


def dotbot(config_file, base_dir):
    """Execute dotbot.

    :param config_file: Dotbot configuration file.
    :type config_file: str
    :param base_dir: Directory to run dotbot in.
    :type base_dir: str

    :returns: Dotbot execution status.
    :rtype: int

    """
    dotbot_bin = os.path.join(DOTBOT_DIR, 'bin/dotbot')
    if os.path.exists(config_file):
        status = subprocess.call([dotbot_bin, "-v", "-d%s" % base_dir, "-c%s" % config_file])
    return status


def deploy():
    """Deploy dotfiles.

    1. Update local repository if necessary.
    2. Deploy a pre-dotfiles local machine dotfiles if necessary
    3. Deploy the dotfiles
    4. Deploy the local machine dotfiles

    """

    # Clone local git repo, update if necessary
    if not os.path.exists(LOCAL_DIR):
        raise OSError("Dotfiles have not been properly initialized")
    os.chdir(LOCAL_DIR)
    git("pull --all")
    os.chdir(DOTFILES_DIR)
    if not os.path.exists(os.path.join(DOTBOT_DIR, "bin/dotbot")):
        raise OSError("Dotfiles have not been properly initialized, dotbot executable not found")
    # Now deploy pre-dotfiles for local machine
#    if dotbot(os.path.join(LOCAL_DIR, 'deploy_pre.yaml'), LOCAL_DIR):
#        raise DotbotError("Error deploying pre-dotfiles for local machine!")
    # Now deploy dotfiles
    if dotbot(os.path.join(DOTFILES_DIR, 'deploy.yaml'), DOTFILES_DIR):
        raise DotbotError("Error deploying dotfiles!")
#    # Now deploy local machine dotfiles
    if dotbot(os.path.join(LOCAL_DIR, 'deploy.yaml'), LOCAL_DIR):
        raise DotbotError("Error deploying dotfiles for local machine!")

if __name__ == '__main__':
    deploy()

# EOF
