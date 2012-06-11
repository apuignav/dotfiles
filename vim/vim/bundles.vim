
" Set filetype on -> off to prevent some versions of vim to explode
filetype on
filetype off

" Set the runtime path
set rtp+=~/.vim/bundle/vundle

" Init Vundle
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Plugin time!
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
"Bundle 'fholgado/minibufexpl.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'sjl/gundo.vim'
Bundle 'majutsushi/tagbar'
if has('gui_running')
  Bundle 'Lokaltog/vim-powerline'
endif
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'vim-scripts/argtextobj.vim'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'sgur/ctrlp-extensions.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
" :)
filetype plugin indent on
