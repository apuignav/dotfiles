"set spell
set spellsuggest=10
" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Hit <c-s> to quickly correct your last spelling error and continue on.
func! SpellCorrect()
    exe "normal! mz[s1z=`z"
endfunc
inoremap <c-s> <esc>:call SpellCorrect()<cr>a
nnoremap <c-s> <esc>:call SpellCorrect()<cr>
