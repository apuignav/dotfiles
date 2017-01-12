if v:version >= 800
    " Run on write
    autocmd! BufWritePost * Neomake
    let g:neomake_error_sign = {'text': 'E>', 'texthl': 'Error'}
    let g:neomake_warning_sign = {'text': 'W>', 'texthl': 'Todo'}
    let g:neomake_info_sign = {'text': 'I>', 'texthl': 'Normal'}
    " Python
    let g:neomake_python_pylama_args = ['--format', 'parsable', '-lpyflakes,pydocstyle,mccabe,pycodestyle', '--ignore=D203,D212,D213,D404,D105']
    " C++
    let g:neomake_c_clang_args = ['-pthread', '-stdlib=libc++', '-std=c++11', '-m64', '-I/usr/local/Cellar/root6/6.04.12/include/root']
    let g:neomake_cpp_clang_args = ['-pthread', '-stdlib=libc++', '-std=c++11', '-m64', '-I/usr/local/Cellar/root6/6.04.12/include/root']
endif
