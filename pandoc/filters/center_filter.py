#!/usr/bin/env python
# -*- coding: utf-8 -*-
# =============================================================================
# @file   column_filter.py
# @author Albert Puig (albert.puig@cern.ch)
# @date   26.06.2015
# =============================================================================
"""Add column creation for pandoc -> beamer, taken from
http://stackoverflow.com/questions/15142134/slides-with-columns-in-pandoc

Usage:

# Hello World

[center]

```python
    if __name__ == "__main__":
        print "Hello World"
```

This is how a "Hello World" looks like in Python

[/center]


"""

import pandocfilters as pf

def latex(string):
    """Process LaTeX string."""
    return pf.RawBlock('latex', string)

def mk_center(key, value, *args):
    """Make LaTeX centering."""
    if key == "Para":
        value = pf.stringify(value)
        if value.startswith('[') and value.endswith(']'):
            content = value[1:-1]
            if content == "center":
                return latex(r'\begin{center}')
            elif content == "/center":
                return latex(r'\end{center}')

if __name__ == "__main__":
    pf.toJSONFilter(mk_center)

# EOF
