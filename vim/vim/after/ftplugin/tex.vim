let b:SuperTabDefaultCompletionType = "<c-x><c-o>"
" LaTeX (rubber) macro
nnoremap <leader>t :w<CR>:!rubber --pdf --warn all %<CR>

" View PDF macro; '%:r' is current file's root (base) name.
nnoremap <leader>v :!open %:r.pdf &<CR><CR>
