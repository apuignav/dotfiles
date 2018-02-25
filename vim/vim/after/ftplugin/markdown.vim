" Open the current document in MacDown.app
setl tabstop=2
setl softtabstop=2
setl makeprg=pandoc\ \"%\"\ -o\ \"%:r.pdf\"\ \&\&\ open\ \"%:r.pdf\"
command! Ql silent !qlmanage -p "%" &> /dev/null

" View PDF macro; '%:r' is current file's root (base) name.
nnoremap <leader>v :!open %:r.pdf &<CR><CR>

" Faster editing
set nocursorline

nmap <silent> K :!open dict://<cword><CR><CR>

