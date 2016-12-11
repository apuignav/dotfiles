if v:version >= 800
    autocmd! BufWritePost * Neomake
    let g:neomake_error_sign = {'text': '>>', 'texthl': 'Error'}
    let g:neomake_warning_sign = {'text': '>>'}
    let g:neomake_python_flake8_maker = {'args': ['--max-line-length=120']}
endif
