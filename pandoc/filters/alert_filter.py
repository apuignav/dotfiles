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
                # Build the content
                final_str = ""
                for element in content:
                    if element['t'] == 'Str':
                        final_str += element['c']
                    elif element['t'] == 'Space':
                        final_str += ' '
                    else:
                        return
                return [latex(r'\alert{%s}' % final_str)]

if __name__ == "__main__":
    pf.toJSONFilter(make_alert)

# EOF
