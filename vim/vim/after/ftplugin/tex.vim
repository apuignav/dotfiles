" let b:SuperTabDefaultCompletionType = "<c-x><c-o>"

" View PDF macro; '%:r' is current file's root (base) name.
nnoremap <leader>v :!open %:r.pdf &<CR><CR>

" Set make
if filereadable("Makefile")
    setl makeprg=make
else
    setl makeprg=latexmk\ -lualatex
endif

" Faster editing
set nocursorline
nmap <silent> <leader>K :!open dict://<cword><CR><CR>

