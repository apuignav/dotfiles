" Search
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set ignorecase                  " ignore case when searching
set smartcase                   " case sensitive when uc present
"clearing highlighted search
nmap <silent> // :nohlsearch<CR>
" Toggle hlsearch with <leader>hs
nmap <leader>hl :set hlsearch! hlsearch?<CR>

" Match it
let b:match_ignorecase = 1

" Automatic no hlsearch
" " :h g:incsearch#auto_nohlsearch
let g:incsearch#auto_nohlsearch = 1
" map n  <Plug>(incsearch-nohl-n)
" map N  <Plug>(incsearch-nohl-N)
" map *  <Plug>(incsearch-nohl-*)
" map #  <Plug>(incsearch-nohl-#)
" map g* <Plug>(incsearch-nohl-g*)
" map g# <Plug>(incsearch-nohl-g#)
" Replace normal search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
