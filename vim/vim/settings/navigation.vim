" General
set virtualedit=onemore         " allow for cursor beyond last character
set nostartofline    " Don’t reset cursor to start of line when moving around.

" Scrolling
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set sidescrolloff=5

" Set wrapping
set linebreak
set wrap
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk
" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" The following two lines conflict with moving to top and bottom of the " screen
" If you prefer that functionality, comment them out.
map <S-H> gT
map <S-L> gt

" Easier horizontal scrolling
map zl zL
map zh zH

" Remember previous position
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"Move back and forth through previous and next buffers
"with ,z and ,x
nnoremap <silent> ,z :bp<CR>
nnoremap <silent> ,x :bn<CR>
