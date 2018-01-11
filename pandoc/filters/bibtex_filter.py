#!/usr/bin/env python
# -*- coding: utf-8 -*-
# =============================================================================
# @file   yaml_bib.py
# @author Albert Puig (albert.puig@cern.ch)
# @date   12.03.2016
# =============================================================================
"""pandoc filter for bibliography."""

from __future__ import unicode_literals

import os

import logging

import bibtexparser

from pandocfilters import toJSONFilter, RawInline

#  logging.basicConfig(filename='filter.log', level=logging.DEBUG)
#  logger = logging.getLogger('bibtexparser.bparser')
#  logger.addHandler(logging.StreamHandler())


ABBREVIATIONS = {'JHEP'                   : 'JHEP',
                 'Nucl. Instrum. Meth.'   : 'Nucl. Instrum. Meth.',
                 'Int. J. Mod. Phys.'     : 'Int. J. Mod. Phys.',
                 'JINST'                  : 'JINST',
                 'New J. Phys.'           : 'New J. Phys.',
                 'Nature'                 : 'Nature',
                 'PoS'                    : 'PoS',
                 'Phys. Rev. Lett.'       : 'Phys. Rev. Lett.',
                 'Nature Physics'         : 'Nature Physics',
                 'IEEE Trans. Nucl. Sci.' : 'IEEE Trans. Nucl. Sci.',
                 'J. Phys.'               : 'J. Phys.',
                 'Nucl. Phys.'            : 'Nucl. Phys.',
                 'Chin. Phys. C'          : 'Chin. Phys. C',
                 'Phys. Rev.'             : 'Phys. Rev.',
                 'Phys. Lett.'            : 'Phys. Lett.',
                 'J. Phys. Conf. Ser.'    : 'J. Phys. Conf. Ser.',
                 'Eur. Phys. J.'          : 'Eur. Phys. J.'}


def latex(string):
    """Convert string to LaTeX."""
    return RawInline('latex', string)


def load_bib(bib_file):
    """Load Bibtex database.

    Abbreviations are applied and LHCb commands removed.

    Arguments:
        bib_file (str): bib file to load.

    Returns:
        bibtexparser.bibdatabase.BibDatabase: Loaded database

    Raises:
        KeyError: If the journal is not recognized

    """
    def customizations(record):
        """Apply customizations to loaded records."""
        if 'journal' in record:
            new_journal = ABBREVIATIONS.get(record['journal'], None)
            if not new_journal:
                raise Exception
            record['journal'] = new_journal
        if 'title' in record:
            if r'\lhcb' in record:
                record['title'] = record['title'].replace(r'\lhcb', 'LHCb')
        return record

    if not os.path.exists(bib_file):
        raise OSError("Cannot find file %s" % bib_file)
    with open(bib_file) as bibtex_file:
        parser = bibtexparser.bparser.BibTexParser()
        parser.ignore_nonstandard_types = False
        parser.customization = customizations
        bib_database = bibtexparser.load(bibtex_file, parser=parser)
    return bib_database


def format_cite(record):
    """Format the record to output.

    Arguments:
        record: BibTexParser record.

    Returns:
        str: What to print.

    Raises:
        KeyError: If cannot format entry.

    """
    entry_type = record['ENTRYTYPE']
    output_str = ''
    eprint = False
    try:
        if entry_type == 'article':
            if not 'journal' in record:
                if 'eprint' in record or \
                        'submitted' in record['note'] or \
                        'to appear' in record['note']:
                    eprint = True
                    output_str += '%s:%s' % (record['archiveprefix'],
                                             record['eprint'])
                else:
                    raise KeyError("No journal info")
            else:
                output_str += record['journal']
            if 'volume' in record:
                output_str += ' %s' % record['volume']
            if not 'year' in record:
                raise KeyError("Missing year")
            output_str += ' (%s)' % record['year']
            if not eprint:
                if not 'pages' in record:
                    output_str = ' doi:%s (%s)' % (record['doi'],
                                                   record['year'])
                else:
                    output_str += ' %s' % record['pages']
        elif entry_type == 'lhcbreport':
            output_str = record['ID']
        elif entry_type == 'mastersthesis':
            output_str = '%s MSc thesis' % record['author']
        elif entry_type == 'phdthesis':
            if 'reportnumber' in record:
                output_str = record['reportnumber']
            else:
                output_str = '%s PhD thesis' % record['author']
        elif entry_type == 'misc':
            output_str = record['howpublished']
        elif entry_type == 'inproceedings':
            if 'doi' in record:
                output_str = 'doi:%s (%s)' % (record['doi'],
                                              record['year'])
            elif 'isbn' in record:
                output_str = 'ISBN:%s (%s)' % (record['isbn'],
                                               record['year'])
                if 'pages' in record:
                    output_str += ' %s' % record['pages']
            else:
                output_str = '%s (%s)' % (record['booktitle'],
                                          record['year'])
                if 'pages' in record:
                    output_str += ' %s' % record['pages']
        if not output_str:
            raise KeyError("Empty output string")
    except KeyError, error:
        print record
        raise KeyError("Cannot format entry %s -> %s" % (record['ID'], error))
    return output_str


# pylint: disable=too-few-public-methods
class BibTeXFormatter(object):
    """Format a Bibtex bibliography."""
    def __init__(self):
        self.bib = None

    def __call__(self, key, value, fmt, meta):
        if self.bib:
            if 'bibliography' in meta:
                self.bib = {}
                bib_files = [file_block['c'][0]['c'] for file_block in meta['bibliography']['c']]
                logging.debug("Found bibliography files -> %s", bib_files)
                for bib_file in bib_files:
                    logging.debug('Loading bibliography -> %s', bib_file)
                    self.bib.update(load_bib(bib_file).entries_dict)
        if self.bib and key == 'Cite':
            #  logging.info(str(value))
            cites = []
            for cite in value[0]:
                cite_str = format_cite(self.bib[cite['citationId']])
                cites.append(latex('[%s]' % cite_str))
            return cites


if __name__ == "__main__":
    toJSONFilter(BibTeXFormatter())

# EOF
