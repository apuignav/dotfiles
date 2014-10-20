" Indent
map <leader>i gg=G''

" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Set paste
map <leader>pp :setlocal paste!<cr>

" For when you forget to sudo. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
