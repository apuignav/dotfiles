" Functions
function! CustomTabularPatterns()
    if exists('g:tabular_loaded')
        AddTabularPattern! eq              /^[^=]*\zs=/l1c1l1
        AddTabularPattern! chunks          / \S\+/l0
    endif
endfunction

autocmd VimEnter * call CustomTabularPatterns()

" Some shortcuts
nmap <Leader>a= :Tabularize eq<CR>
vmap <Leader>a= :Tabularize eq<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>


" Automatic alignment of  | |
" Commented out because not needed, but left as reference
" inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" function! s:align()
    " let p = '^\s*|\s.*\s|\s*$'
    " if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        " let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        " let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        " Tabularize/|/l1
        " normal! 0
        " call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    " endif
" endfunction
