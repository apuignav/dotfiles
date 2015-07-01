#!/usr/bin/env python
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
                content = value[0]['c']
                if len(content) == 1:
                    if content[0]['t'] == 'Str':
                        return [latex(r'\alert{%s}' % content[0]['c'])]

if __name__ == "__main__":
    pf.toJSONFilter(make_alert)

# EOF
