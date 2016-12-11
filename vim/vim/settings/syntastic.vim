if v:version < 800
    let g:syntastic_enable_highlighting = 1
    "let g:syntastic_error_symbol = '✗'
    "let g:syntastic_warning_symbol = '⚠'
    let g:syntastic_aggregate_errors = 0
    let g:syntastic_cpp_include_dirs = ['/usr/local/opt/root/include/root/', 'include']
    let g:syntastic_c_include_dirs = ['/usr/local/opt/root/include/root/', 'include']
    "let g:syntastic_quiet_warnings=0
    "let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['cpp'] }
    let g:syntastic_python_checkers=['pylint', 'flake8']
    let g:syntastic_python_pylint_args = '--rcfile=~/.pylintrc'
    let g:syntastic_python_flake8_args = '--max-line-length=100'
    let g:syntastic_tex_checkers=['']
endif
