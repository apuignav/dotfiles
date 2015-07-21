" ========================================
" Vim plugin configuration
" ========================================
"
" This file contains the list of plugin installed using vundle plugin manager.
" Filetype off is required by vundle
filetype on

call plug#begin()

" Use local bundles if available {
if filereadable(expand("~/.vimrc.bundles.local"))
    source ~/.vimrc.bundles.local
endif
" }

" In the .vimrc.bundles.local file
" list only the plugin groups to use
if !exists('g:bundle_groups')
    let g:bundle_groups=['general', 'programming', 'python', 'misc', 'ultisnips', 'last']
    " let g:bundle_groups=['test']
endif

" To override all the included bundles, put
" g:override_bundles = 1
" in the .vimrc.bundles.local file
if !exists("g:override_bundles")
    " General
    if count(g:bundle_groups, 'general')
        Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
        Plug 'tpope/vim-surround'
        Plug 'tpope/vim-dispatch'
        Plug 'Townk/vim-autoclose'
        Plug 'kien/ctrlp.vim'
        Plug 'matchit.zip'
        Plug 'bling/vim-airline'
        Plug 'Lokaltog/vim-easymotion'
        Plug 'jistr/vim-nerdtree-tabs'
        " Plug 'corntrace/bufexplorer'
        Plug 'jeetsukumaran/vim-buffergator'
        Plug 'mbbill/undotree'
        Plug 'vim-scripts/bufkill.vim'
        Plug 'maxbrunsfeld/vim-yankstack'
        Plug 'ervandew/supertab'
        Plug 'thomwiggers/vim-colors-solarized'
        if executable('ag')
            Plug 'rking/ag.vim'
        else
            if executable('ack-grep')
                let g:ackprg="ack-grep -H --nocolor --nogroup --column"
                Plug 'mileszs/ack.vim'
            elseif executable('ack')
                Plug 'mileszs/ack.vim'
            endif
        endif
        Plug 'kristijanhusak/vim-multiple-cursors'
        Plug 'EinfachToll/DidYouMean'
        Plug 'DavidGamba/vim-vmath'
        Plug 'vim-pandoc/vim-pandoc-syntax'
        Plug 'vim-pandoc/vim-pandoc'
    endif

    " General Programming
    if count(g:bundle_groups, 'programming')
        Plug 'scrooloose/syntastic'
        let g:syntastic_enable_highlighting = 1
        "let g:syntastic_error_symbol = '✗'
        "let g:syntastic_warning_symbol = '⚠'
        let g:syntastic_aggregate_errors = 0
        Plug 'tpope/vim-fugitive'
        Plug 'gregsexton/gitv'
        if version > 701
            Plug 'scrooloose/nerdcommenter'
        endif
        Plug 'godlygeek/tabular'
        Plug 'Rip-Rip/clang_complete', {'for': ['cpp', 'c']}
        if executable('ctags')
            " Plug 'thawk/OmniCppComplete'
            Plug 'majutsushi/tagbar'
        endif
        Plug 'michaeljsmith/vim-indent-object'
        Plug 'vim-scripts/argtextobj.vim'
        Plug 'mutewinter/swap-parameters'
        Plug 'gregsexton/MatchTag'
    endif

    " Python
    if count(g:bundle_groups, 'python')
        if version > 701
            Plug 'davidhalter/jedi-vim', {'for': 'python'}
        endif
        Plug 'klen/python-mode', {'for': 'python'}
        Plug 'python.vim', {'for': 'python'}
        Plug 'python_match.vim', {'for': 'python'}
        Plug 'pythoncomplete', {'for': 'python'}
        Plug 'apuignav/vim-gf-python', {'for': 'python'}
        Plug 'thinca/vim-quickrun', {'for': 'python'}
    endif

    " Misc
    if count(g:bundle_groups, 'misc')
        " Plug 'LaTeX-Box-Team/LaTeX-Box', {'for': ['tex', 'latex']}
        Plug 'lervag/vimtex', {'for': ['tex', 'latex']}
        Plug 'parnmatt/vim-root'
        " Plug 'tpope/vim-markdown', {'for': ['mkd', 'markdown']}
        Plug 'junegunn/goyo.vim', {'for': ['markdown', 'mkd', 'tex']}
        Plug 'amix/vim-zenroom2', {'for': ['markdown', 'mkd']}
        Plug 'chrisbra/csv.vim', {'for': 'csv'}
        " Plug 'tpope/vim-speeddating'
    endif

    " Ultisnips
    if count(g:bundle_groups, 'ultisnips')
        Plug 'MarcWeber/vim-addon-mw-utils'
        Plug 'tomtom/tlib_vim'
        Plug 'SirVer/ultisnips'
        Plug 'honza/vim-snippets'
    endif

    if count(g:bundle_groups, 'test')
        Plug 'davidhalter/jedi-vim'
        " Plug 'Valloric/YouCompleteMe'
    endif

    if count(g:bundle_groups, 'unite')
        " Resources
        " http://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
        " https://github.com/Shougo/unite.vim
        " http://www.codeography.com/2013/06/17/replacing-all-the-things-with-unite-vim.html
        Plug 'Shougo/vimproc.vim', {'do': 'make'}
        Plug 'Shougo/unite.vim'
    endif

    if count(g:bundle_groups, 'last')
        Plug 'tpope/vim-unimpaired'
    endif

endif

call plug#end()
