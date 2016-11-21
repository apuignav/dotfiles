" Function
function! NERDTreeInitAsNeeded()
    redir => bufoutput
    buffers!
    redir END
    let idx = stridx(bufoutput, "NERD_tree")
    if idx > -1
        NERDTreeTabsMirror
        NERDTreeTabsFind
        wincmd l
    endif
endfunction
" Config
let g:NERDShutUp = 1
let g:NERDSpaceDelims = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:nerdtree_tabs_open_on_gui_startup = 0
let NERDTreeShowBookmarks = 0
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode = 0
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 0
let NERDTreeKeepTreeInNewTab = 1

" Keybindings
map <C-e> :NERDTreeTabsToggle<CR>
map <leader>e :NERDTreeFind<CR>

" Auto commands
"autocmd vimenter * if !argc() | NERDTree | endif " Open NERDTree if vim is opened without any file
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Close vim if NERDTree is the only thing opened
