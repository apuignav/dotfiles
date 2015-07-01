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

[columns]

[column=0.5]

```python
    if __name__ == "__main__":
        print "Hello World"
```

[column=0.5]

This is how a "Hello World" looks like in Python

[/columns]


"""

import pandocfilters as pf

def latex(string):
    """Process LaTeX string."""
    return pf.RawBlock('latex', string)

def mk_columns(key, value, *args):
    """Make LaTeX columns."""
    if key == "Para":
        value = pf.stringify(value)
        if value.startswith('[') and value.endswith(']'):
            content = value[1:-1]
            if content == "columns":
                return latex(r'\begin{columns}')
            elif content == "/columns":
                return latex(r'\end{columns}')
            elif content.startswith("column="):
                return latex(r'\column{%s\textwidth}' % content[7:])

if __name__ == "__main__":
    pf.toJSONFilter(mk_columns)

# EOF
