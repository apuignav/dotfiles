" ========================================
" Vim plugin configuration
" ========================================
"
" This file contains the list of plugin installed using vundle plugin manager.
" Filetype off is required by vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.vim/vundles/ "Submodules
call vundle#rc()

Plugin 'gmarik/vundle'

" Use local bundles if available {
if filereadable(expand("~/.vimrc.bundles.local"))
    source ~/.vimrc.bundles.local
endif
" }
"
" In the .vimrc.bundles.local file
" list only the plugin groups to use
if !exists('g:bundle_groups')
    let g:bundle_groups=['general', 'programming', 'python', 'misc', 'ultisnips']
    " let g:bundle_groups=['test']
endif

" To override all the included bundles, put
" g:override_bundles = 1
" in the .vimrc.bundles.local file
if !exists("g:override_bundles")
    " General
    if count(g:bundle_groups, 'general')
        Plugin 'scrooloose/nerdtree'
        Plugin 'tpope/vim-surround'
        Plugin 'Townk/vim-autoclose'
        Plugin 'kien/ctrlp.vim'
        Plugin 'matchit.zip'
        Plugin 'bling/vim-airline'
        Plugin 'Lokaltog/vim-easymotion'
        Plugin 'jistr/vim-nerdtree-tabs'
        Plugin 'corntrace/bufexplorer'
        Plugin 'mbbill/undotree'
        Plugin 'vim-scripts/bufkill.vim'
        Plugin 'maxbrunsfeld/vim-yankstack'
        Plugin 'ervandew/supertab'
        Plugin 'thomwiggers/vim-colors-solarized'
        if executable('ag')
            Plugin 'rking/ag.vim'
        else
            if executable('ack-grep')
                let g:ackprg="ack-grep -H --nocolor --nogroup --column"
                Plugin 'mileszs/ack.vim'
            elseif executable('ack')
                Plugin 'mileszs/ack.vim'
            endif
        endif
        Plugin 'tpope/vim-unimpaired'
    endif

    " General Programming
    if count(g:bundle_groups, 'programming')
        Plugin 'scrooloose/syntastic'
        let g:syntastic_enable_highlighting = 1
        "let g:syntastic_error_symbol = '✗'
        "let g:syntastic_warning_symbol = '⚠'
        let g:syntastic_aggregate_errors = 0
        Plugin 'tpope/vim-fugitive'
        if version > 701
            Plugin 'scrooloose/nerdcommenter'
        endif
        Plugin 'godlygeek/tabular'
        Plugin 'Rip-Rip/clang_complete'
        if executable('ctags')
            " Plugin 'thawk/OmniCppComplete'
            Plugin 'majutsushi/tagbar'
        endif
        Plugin 'michaeljsmith/vim-indent-object'
        Plugin 'vim-scripts/argtextobj.vim'
        Plugin 'mutewinter/swap-parameters'
        Plugin 'gregsexton/MatchTag'
    endif

    " Python
    if count(g:bundle_groups, 'python')
        if version > 701
            Plugin 'davidhalter/jedi-vim'
        endif
        Plugin 'klen/python-mode'
        Plugin 'python.vim'
        Plugin 'python_match.vim'
        Plugin 'pythoncomplete'
        Plugin 'apuignav/vim-gf-python'
    endif

    " Misc
    if count(g:bundle_groups, 'misc')
        Plugin 'LaTeX-Box-Team/LaTeX-Box'
        Plugin 'parnmatt/vim-root'
        Plugin 'amix/vim-zenroom2'
        Plugin 'junegunn/goyo.vim'
    endif

    " Ultisnips
    if count(g:bundle_groups, 'ultisnips')
        Plugin 'MarcWeber/vim-addon-mw-utils'
        Plugin 'tomtom/tlib_vim'
        Plugin 'SirVer/ultisnips'
        Plugin 'honza/vim-snippets'
    endif

    if count(g:bundle_groups, 'test')
        Plugin 'Valloric/YouCompleteMe'
    endif

    if count(g:bundle_groups, 'unite')
        " Resources
        " http://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
        " https://github.com/Shougo/unite.vim
        " http://www.codeography.com/2013/06/17/replacing-all-the-things-with-unite-vim.html
        Plugin 'Shougo/vimproc.vim'
        Plugin 'Shougo/unite.vim'
    endif

endif
