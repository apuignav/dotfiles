" Open the current document in MacDown.app
nmap <leader>p :silent !open -a MacDown.app %<CR>
set tabstop=2
set softtabstop=2
set makeprg=pandoc\ -t\ beamer\ -V\ theme:m\ -V\ themeopts:progressbar=frametitle,noframetitleoffset,block=fill\ --latex-engine\ xelatex\ --template\ ~/dotfiles/pandoc/templates/default.beamer\ --filter\ ~/dotfiles/pandoc/filters/alert_filter.py\ -s\ \"%\"\ -o\ \"%:r.pdf\"
