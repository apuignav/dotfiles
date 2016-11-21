" Open the Ag command and place the cursor into the quotes
if executable('rg')
    let g:ackprg = 'rg --vimgrep --no-heading'
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
elseif executable('aco-grep')
    let g:ackprg="ack-grep -H --nocolor --nogroup --column"
endif
nmap <leader>f :Ack ""<Left>
" nmap ,ag :Ag ""<Left>
" nmap ,af :AgFile ""<Left>
