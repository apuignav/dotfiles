if v:version >= 800
    call neomake#config#set('ft.python.pylama.exe', 'pylava')
    call neomake#config#set('ft.python.python.exe', 'python3')
    " Check battery
    function! MyOnBattery()
        let answer = system("system_profiler SPPowerDataType | grep Connected | awk '{print $2}'")
        let answer = substitute(answer, '\n$', '', '')
        return answer == 'No'
    endfunction
    
    " Run on write
    let g:neomake_python_enabled_makers = ['pylama', 'pydocstyle']
    "let g:neomake_python_enabled_makers += ['pydocstyle']
    "autocmd! BufWritePost * Neomake
    let g:neomake_error_sign = {'text': 'E>', 'texthl': 'Error'}
    let g:neomake_warning_sign = {'text': 'W>', 'texthl': 'Todo'}
    let g:neomake_info_sign = {'text': 'I>', 'texthl': 'Normal'}
    " Python
    call neomake#config#set('ft.python.pylama.args', ['--format', 'parsable', '-lpyflakes,mccabe,pycodestyle,pylint', '--ignore=D203,D212,D213,D404,D105,I0011'])
    " C++
    call neomake#config#set('ft.c.clang.args', ['-pthread', '-stdlib=libc++', '-std=c++11', '-m64', '-I/usr/local/opt/root/include/root/'])
    call neomake#config#set('ft.cpp.clang.args', ['-pthread', '-stdlib=libc++', '-std=c++11', '-m64', '-I/usr/local/opt/root/include/root/'])
    if MyOnBattery()
        call neomake#configure#automake('w')
    else
        call neomake#configure#automake('nw', 1000)
    endif
        
endif
