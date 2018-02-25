" let b:SuperTabDefaultCompletionType = "<c-x><c-o>"

" View PDF macro; '%:r' is current file's root (base) name.
nnoremap <leader>v :!open %:r.pdf &<CR><CR>

" Set make
setl makeprg=([[\ -f\ Makefile\ ]]\ &&\ (make\ $*;\ true)\\\|\\\|\ latexrun\ --latex-cmd=xelatex\ \"%\"\ $*)

" Faster editing
set nocursorline
nmap <silent> <leader>K :!open dict://<cword><CR><CR>

