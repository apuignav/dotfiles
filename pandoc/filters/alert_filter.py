#!/usr/bin/env python2
# -*- coding: utf-8 -*-
# =============================================================================
# @file   alert_filter.py
# @author Albert Puig (albert.puig@cern.ch)
# @date   01.07.2015
# =============================================================================
"""Create an \alert emphasis with triple asterisks or triple underscores."""


import pandocfilters as pf

def latex(string):
    """Process LaTeX string."""
    return pf.RawInline('latex', string)

def make_alert(key, value, *args):
    """Make beamer alerts."""
    if key == "Strong":
        if len(value) == 1:
            if value[0]['t'] == 'Emph':
                return [latex(r'\alert{')] + value[0]['c'] + [latex(u'}')]

if __name__ == "__main__":
    pf.toJSONFilter(make_alert)

# EOF
