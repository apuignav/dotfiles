let g:syntastic_cpp_include_dirs = ['/usr/local/opt/root/include/root/', 'include']
let g:syntastic_c_include_dirs = ['/usr/local/opt/root/include/root/', 'include']
"let g:syntastic_quiet_warnings=0
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['cpp'] }
let g:syntastic_python_checkers=['pylint', 'flake8']
let g:syntastic_python_pylint_args = '--rcfile=~/.pylintrc'
let g:syntastic_python_flake8_args = '--max-line-length=99'
let g:syntastic_tex_checkers=['']
