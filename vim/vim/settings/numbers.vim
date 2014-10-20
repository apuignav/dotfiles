" Configure line numbers
function! NumberToggle()
  if( &relativenumber == 1 )
    set number
    set norelativenumber
  else
    set number
    set relativenumber
  endif
endfunc

" Keybinding
set number
nnoremap <leader>n :call NumberToggle()<cr>
