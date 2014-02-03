#!/usr/bin/env python
# =============================================================================
# @file   deploy.py
# @author Albert Puig (albert.puig@epfl.ch)
# @date   03.02.2014
# =============================================================================
"""Install things needed for python."""

import os

packages = [ 'Fabric',
             'beautifulsoup4',
             'fitbit',
             'fonttools',
             'fuzzywuzzy',
             'ipython',
             'line_profiler',
             'memory_profiler',
             'numpy',
             'matplotlib',
             'progressbar',
             'psutil',
             'pyflakes',
             'pylint',
             'radon',
             'scipy',
             'sh',
             'subliminal',
             'paramiko',
             'nose',
             'PyYAML',
             'pycolors',
             'oauth2',
             'pathfinder'
           ]

if __name__ == '__main__':
    os.system('pip install -U %s' % (' '.join(packages)))

# EOF
