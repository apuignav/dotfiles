autocmd FileType python setlocal completeopt-=preview

" Set sign column for neovim
set signcolumn=yes

" Point YCM to the Pipenv created virtualenv, if possible
" At first, get the output of 'pipenv --venv' command.
let pipenv_venv_path = system('PIPENV_MAX_DEPTH=10 pipenv --venv')
" The above system() call produces a non zero exit code whenever
" a proper virtual environment has not been found.
" So, second, we only point YCM to the virtual environment when
" the call to 'pipenv --venv' was successful.
" Remember, that 'pipenv --venv' only points to the root directory
" of the virtual environment, so we have to append a full path to
" the python executable.
if shell_error == 0
  let venv_path = substitute(pipenv_venv_path, '\n', '', '')
  let g:ycm_python_binary_path = venv_path . '/bin/python'
  if filereadable(venv_path . '/bin/pylama')
      let g:neomake_python_pylama_exe = venv_path . '/bin/pylama'
  endif
endif
