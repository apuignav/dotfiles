autocmd FileType python setlocal completeopt-=preview
autocmd BufWritePre *.py silent execute ':Ruff'

" Set sign column for neovim
set signcolumn=yes

if !empty($VIRTUAL_ENV)
  let g:ycm_python_binary_path = $VIRTUAL_ENV . '/bin/python'
  if filereadable($VIRTUAL_ENV . '/bin/python3')
      call neomake#config#set('ft.python.python.exe', $VIRTUAL_ENV . '/bin/python3')
  endif
  "if filereadable($VIRTUAL_ENV . '/bin/pylava')
  "    call neomake#config#set('ft.python.pylama.exe', $VIRTUAL_ENV . '/bin/pylava')
  "endif
  if filereadable($VIRTUAL_ENV . '/bin/frosted')
      call neomake#config#set('ft.python.frosted.exe', $VIRTUAL_ENV . '/bin/frosted')
  endif
  if filereadable($VIRTUAL_ENV . '/bin/pylint')
      call neomake#config#set('ft.python.pylint.exe', $VIRTUAL_ENV . '/bin/pylint')
  endif
  if filereadable($VIRTUAL_ENV . '/bin/flake8')
      call neomake#config#set('ft.python.flake8.exe', $VIRTUAL_ENV . '/bin/flake8')
  endif
endif

