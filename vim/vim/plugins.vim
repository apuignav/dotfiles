" ========================================
" Vim plugin configuration
" ========================================
"
" This file contains the list of plugin installed using vundle plugin manager.
" Filetype off is required by vundle
filetype on

call plug#begin()

" Use local bundles if available {
if filereadable(expand('~/.vimrc.bundles.local'))
    source ~/.vimrc.bundles.local
endif
" }

" In the .vimrc.bundles.local file
" list only the plugin groups to use
if !exists('g:bundle_groups')
    let g:bundle_groups=['general', 'programming', 'python', 'misc', 'ultisnips', 'last']
    "let g:bundle_groups=['test']
endif

" To override all the included bundles, put
" g:override_bundles = 1
" in the .vimrc.bundles.local file
if !exists('g:override_bundles')
    " General
    if count(g:bundle_groups, 'general')
        "Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeTabsToggle']}
        Plug 'tpope/vim-surround'
        Plug 'tpope/vim-dispatch'
        " Plug 'Townk/vim-autoclose'
        "Plug 'jiangmiao/auto-pairs'
        Plug 'kien/ctrlp.vim'
        "Plug 'vim-scripts/matchit.zip'
        Plug 'bling/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        " Plug 'justinmk/vim-sneak'
        "Plug 'jistr/vim-nerdtree-tabs'
        " Plug 'corntrace/bufexplorer'
        Plug 'jeetsukumaran/vim-buffergator'
        Plug 'mbbill/undotree'
        Plug 'vim-scripts/bufkill.vim'
        Plug 'maxbrunsfeld/vim-yankstack'
        Plug 'nordtheme/vim'
        "Plug 'morhetz/gruvbox'
        Plug 'mileszs/ack.vim'
        Plug 'kristijanhusak/vim-multiple-cursors'
        Plug 'EinfachToll/DidYouMean'
        Plug 'DavidGamba/vim-vmath'
        Plug 'vim-pandoc/vim-pandoc'
        Plug 'vim-pandoc/vim-pandoc-syntax'
        "Plug 'https://git.danielmoch.com/vim-makejob'
    endif

    " General Programming
    if count(g:bundle_groups, 'programming')
        if v:version >= 800
            "Plug 'metakirby5/codi.vim'
            Plug 'neomake/neomake'
        else
            Plug 'scrooloose/syntastic'
        endif
        Plug 'tpope/vim-fugitive'
        "Plug 'gregsexton/gitv'
        if v:version > 701
            Plug 'scrooloose/nerdcommenter'
        endif
        Plug 'godlygeek/tabular'
        Plug 'Rip-Rip/clang_complete', {'for': ['cpp', 'c', 'h']}
        if executable('ctags')
            " Plug 'thawk/OmniCppComplete'
            Plug 'majutsushi/tagbar'
        endif
        Plug 'michaeljsmith/vim-indent-object'
        Plug 'vim-scripts/argtextobj.vim'
        Plug 'machakann/vim-swap'
        Plug 'gregsexton/MatchTag'
        "Plug 'Valloric/YouCompleteMe', {'do': 'python3 install.py --clang-completer'}
        Plug 'vim-python/python-syntax'
        Plug 'derekwyatt/vim-scala', {'for': ['scala']}
        Plug 'cespare/vim-toml'
        "Plug 'cjrh/vim-conda'
    endif

    " Python
    if count(g:bundle_groups, 'python')
        " if version > 701
        " Plug 'davidhalter/jedi-vim', {'for': 'python'}
        " endif
        Plug 'klen/python-mode', {'for': 'python'}
        Plug 'vim-scripts/python.vim', {'for': 'python'}
        Plug 'vim-scripts/python_match.vim', {'for': 'python'}
        " Plug 'pythoncomplete', {'for': 'python'}
        Plug 'apuignav/vim-gf-python', {'for': 'python'}
        Plug 'thinca/vim-quickrun', {'for': 'python'}
        Plug 'psf/black', {'for': 'python'}
    endif

    " Misc
    if count(g:bundle_groups, 'misc')
        " Plug 'LaTeX-Box-Team/LaTeX-Box', {'for': ['tex', 'latex']}
        Plug 'lervag/vimtex', {'for': ['tex', 'latex']}
        " Plug 'tpope/vim-markdown', {'for': ['mkd', 'markdown']}
        Plug 'junegunn/goyo.vim', {'for': ['markdown', 'mkd', 'tex']}
        Plug 'dbmrq/vim-ditto', {'for': ['markdown', 'mkd']}
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
        "Plug 'Shougo/deoplete.nvim'
        "Plug 'roxma/nvim-yarp'
        "Plug 'roxma/vim-hug-neovim-rpc'
        "Plug 'deoplete-plugins/deoplete-jedi'
        "let g:deoplete#enable_at_startup = 1
        "let g:deoplete#sources#jedi#enable_typeinfo = 0
        "Plug 'Valloric/YouCompleteMe', {'do': 'python3 install.py --clang-completer'}
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
