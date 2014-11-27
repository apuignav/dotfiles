" Search
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set ignorecase                  " ignore case when searching
set smartcase                   " case sensitive when uc present
"clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>
" Toggle hlsearch with <leader>hs
nmap <leader>hl :set hlsearch! hlsearch?<CR>

" Match it
let b:match_ignorecase = 1

