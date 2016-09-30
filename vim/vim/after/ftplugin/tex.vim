" let b:SuperTabDefaultCompletionType = "<c-x><c-o>"

" View PDF macro; '%:r' is current file's root (base) name.
nnoremap \v :!open %:r.pdf &<CR><CR>

" Set make
set makeprg=([[\ -f\ Makefile\ ]]\ &&\ (make\ $*;\ true)\\\|\\\|\ latexrun\ --latex-cmd=xelatex\ \"%\"\ $*)

" Faster editing
set nocursorline

