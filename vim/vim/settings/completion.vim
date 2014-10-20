" Omnicomplete
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
        \if &omnifunc == "" |
        \setlocal omnifunc=syntaxcomplete#Complete |
        \endif
endif

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
"set completeopt=menu,preview,longest
set completeopt=menu,longest

" Ctags 
set tags=./tags;/,~/.vimtags,~/.vim/tags/root.tags

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.class,.pdf
