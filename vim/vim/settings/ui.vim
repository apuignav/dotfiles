set background=dark     " Assume a dark background
colorscheme solarized
set tabpagemax=15               " only show 15 tabs
set showmode                    " display the current mode
set title            " Show the filename in the window titlebar

set cursorline                  " highlight current line
" GVIM- (here instead of .gvimrc)
if has('gui_running')
    if has('gui_macvim')
        set transparency=0
    endif
    set guioptions-=T           " remove the toolbar
    set guioptions=-t
    "set lines=50                " 40 lines of text instead of 24,
    set guifont=Source_Code_Pro_for_Powerline:h13
else
    set t_Co=256                 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
endif
" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
" Use local gvimrc if available and gui is running {
if has('gui_running')
    if filereadable(expand("~/.gvimrc.local"))
        source ~/.gvimrc.local
    endif
endif
