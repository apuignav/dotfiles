" Set undo
if has('persistent_undo')
    set undofile                "so is persistent undo ...
    set undolevels=1000         "maximum number of changes that can be undone
    set undoreload=10000        "maximum number lines to save for undo on a buffer reload
    set undodir=~/.vim/undo
endif

" Plugin config

" Open on the right so as not to compete with the nerdtree
let g:undotree_WindowLayout = 3
" a little wider for wider screens
let g:undotree_SplitWidth = 60
" focuts undotree on invocation
let g:undotree_SetFocusWhenToggle = 1

" Keybindings
nnoremap <c-u> :UndotreeToggle<CR>
nmap ,u :UndotreeToggle<CR>

