if v:version >= 800
    " Run on write
    autocmd! BufWritePost * Neomake
    let g:neomake_error_sign = {'text': '>>', 'texthl': 'Error'}
    let g:neomake_warning_sign = {'text': '>>', 'texthl': 'Todo'}
    " Python
    let g:neomake_python_flake8_maker = {'args': ['--max-line-length=120']}

    let g:neomake_c_clang_maker = {'args': ['-pthread', '-stdlib=libc++', '-std=c++11', '-m64', '-I/usr/local/Cellar/root6/6.04.12/include/root']}
    let g:neomake_cpp_clang_maker = {'args': ['-pthread', '-stdlib=libc++', '-std=c++11', '-m64', '-I/usr/local/Cellar/root6/6.04.12/include/root']}
endif
