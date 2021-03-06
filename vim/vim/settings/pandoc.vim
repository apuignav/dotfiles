"Settings for pandoc plugins

"Disable annoying syntax changes
let g:pandoc#syntax#conceal#use = 0

" let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 1

" Disable folding and keyboard shortcuts
let g:pandoc#modules#disabled = ["folding", "keyboard", "chdir"]

" Set text width
let g:pandoc#formatting#textwidth = 100

" Disable message buffer
let g:pandoc#command#use_message_buffer = 1

" Set spelling language
let g:pandoc#spell#default_langs = ["en_gb", "es"]

" Manage open in Mac
"if system('uname') =~# 'Darwin'
"    let g:pandoc#command#custom_open = "PreviewOpen"
"    function! PreviewOpen(file)
"        return "open -a ". a:file
"    endfunction
"endif

" LaTeX config
let g:pandoc#command#latex_engine = "xelatex"

" Templates
let g:pandoc#command#templates_file = $HOME. '/.vim/vim-pandoc-templates'