autocmd FileType python setlocal completeopt-=preview

" Set sign column for neovim
set signcolumn=yes

if !empty($VIRTUAL_ENV)
  let g:ycm_python_binary_path = $VIRTUAL_ENV . '/bin/python'
  if filereadable($VIRTUAL_ENV . '/bin/python3')
      call neomake#config#set('ft.python.python.exe', $VIRTUAL_ENV . '/bin/python3')
  endif
  if filereadable($VIRTUAL_ENV . '/bin/pylava')
      call neomake#config#set('ft.python.pylama.exe', $VIRTUAL_ENV . '/bin/pylava')
  endif
  if filereadable($VIRTUAL_ENV . '/bin/frosted')
      call neomake#config#set('ft.python.frosted.exe', $VIRTUAL_ENV . '/bin/frosted')
  endif
endif

