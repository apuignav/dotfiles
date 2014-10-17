# see https://github.com/mooz/percol

# Emacs like keymap
percol.import_keymap({
    "C-h" : lambda percol: percol.command.delete_backward_char(),
    "C-d" : lambda percol: percol.command.delete_forward_char(),
    "C-k" : lambda percol: percol.command.kill_end_of_line(),
    "C-y" : lambda percol: percol.command.yank(),
    "C-t" : lambda percol: percol.command.transpose_chars(),
    "C-a" : lambda percol: percol.command.beginning_of_line(),
    "C-e" : lambda percol: percol.command.end_of_line(),
    "C-b" : lambda percol: percol.command.backward_char(),
    "C-f" : lambda percol: percol.command.forward_char(),
    "C-m" : lambda percol: percol.finish(),
    "C-j" : lambda percol: percol.finish(),
    "C-c" : lambda percol: percol.cancel(),
})

# mark and next
# from http://qiita.com/syui/items/f2fe51d00378210d10b1
percol.import_keymap({
    "C-n" : lambda percol: percol.command.toggle_mark_and_next(),
    "C-v" : lambda percol: percol.command.mark_all(),
    "C-b" : lambda percol: percol.command.unmark_all(),
})

# Mode
from percol.finder import FinderMultiQueryMigemo, FinderMultiQueryRegex
percol.import_keymap({
    "C-p" : lambda percol: percol.command.toggle_case_sensitive(),
    "C-r" : lambda percol: percol.command.toggle_finder(FinderMultiQueryRegex)
})

## prompt
# see http://www.kaichan.info/blog/2012-11-21-percol-new-features.html
# %q: query w/ caret
# %i: current line number
# %I: total line number
# %n: current page number
# %N: total page number

# Change PROMPT in response to the status of case sensitivity
percol.view.__class__.PROMPT = property(
    lambda self:
    ur"<bold><blue>QUERY </blue>[a]:</bold> %q" if percol.model.finder.case_insensitive
    else ur"<bold><yellow>QUERY </yellow>[A]:</bold> %q"
)
# Display finder name in RPROMPT
percol.view.prompt_replacees["F"] = lambda self, **args: self.model.finder.get_name()
percol.view.RPROMPT = ur"\<%F\> (%i/%I) [%n/%N]"

# Colors
percol.view.CANDIDATES_LINE_BASIC    = ("on_default", "default")
percol.view.CANDIDATES_LINE_SELECTED = ("on_blue", "white", "dim")
percol.view.CANDIDATES_LINE_MARKED   = ("bold", "on_cyan", "black")
percol.view.CANDIDATES_LINE_QUERY    = ("red", "bold")

## /prompt
