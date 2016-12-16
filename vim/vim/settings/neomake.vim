if v:version >= 800
    " Run on write
    autocmd! BufWritePost * Neomake
    let g:neomake_error_sign = {'text': 'E>', 'texthl': 'Error'}
    let g:neomake_warning_sign = {'text': 'W>', 'texthl': 'Todo'}
    " Python
    let g:neomake_python_pylama_args = ['--format', 'parsable', '-lpyflakes,pydocstyle,mccabe,pycodestyle']
    " C++
    let g:neomake_c_clang_args = ['-pthread', '-stdlib=libc++', '-std=c++11', '-m64', '-I/usr/local/Cellar/root6/6.04.12/include/root']
    let g:neomake_cpp_clang_args = ['-pthread', '-stdlib=libc++', '-std=c++11', '-m64', '-I/usr/local/Cellar/root6/6.04.12/include/root']
endif
