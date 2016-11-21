" Keybindings
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gf :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
" find merge conflict markers
" nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Vertical split for gdiff buffers
set diffopt+=vertical

" Every time you open a git object using fugitive it creates a new buffer. 
" This means that your buffer listing can quickly become swamped with 
" fugitive buffers. This prevents this from becomming an issue:
autocmd BufReadPost fugitive://* set bufhidden=delete

" Gitv
"nmap <leader>gv :Gitv --all<cr>
"nmap <leader>gV :Gitv! --all<cr>
"vmap <leader>gV :Gitv! --all<cr>
