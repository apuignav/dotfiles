if v:version >= 800
    call neomake#config#set('ft.python.pylama.exe', 'pylava')
    let g:neomake_python_python_exe = 'python3'
    " Check battery
    function! MyOnBattery()
        let answer = system("system_profiler SPPowerDataType | grep Connected | awk '{print $2}'")
        let answer = substitute(answer, '\n$', '', '')
        return answer == 'No'
    endfunction
    
    " Run on write
    autocmd! BufWritePost * Neomake
    let g:neomake_error_sign = {'text': 'E>', 'texthl': 'Error'}
    let g:neomake_warning_sign = {'text': 'W>', 'texthl': 'Todo'}
    let g:neomake_info_sign = {'text': 'I>', 'texthl': 'Normal'}
    " Python
    let g:neomake_python_pylama_args = ['--format', 'parsable', '-lpyflakes,pydocstyle,mccabe,pycodestyle,pylint', '--ignore=D203,D212,D213,D404,D105,I0011']
    " C++
    let g:neomake_c_clang_args = ['-pthread', '-stdlib=libc++', '-std=c++11', '-m64', '-I/usr/local/opt/root/include/root/']
    let g:neomake_cpp_clang_args = ['-pthread', '-stdlib=libc++', '-std=c++11', '-m64', '-I/usr/local/opt/root/include/root/']
    if MyOnBattery()
        call neomake#configure#automake('w')
    else
        call neomake#configure#automake('nw', 1000)
    endif
        
endif
