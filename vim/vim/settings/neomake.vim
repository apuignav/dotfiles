if v:version >= 800
    "call neomake#config#set('ft.python.pylama.exe', 'pylava')
    call neomake#config#set('ft.python.python.exe', 'python3')
    " Check battery
    function! MyOnBattery()
        let answer = system("system_profiler SPPowerDataType | grep Connected | awk '{print $2}'")
        let answer = substitute(answer, '\n$', '', '')
        return answer == 'No'
    endfunction
    
    " Run on write
    "let g:neomake_python_enabled_makers = ['pylama']
    "let g:neomake_python_enabled_makers = ['pylama', 'pydocstyle']
    "let g:neomake_python_enabled_makers += ['pydocstyle']
    "autocmd! BufWritePost * Neomake
    let g:neomake_error_sign = {'text': 'E>', 'texthl': 'Error'}
    let g:neomake_warning_sign = {'text': 'W>', 'texthl': 'Todo'}
    let g:neomake_info_sign = {'text': 'I>', 'texthl': 'Normal'}
    " Python
    "call neomake#config#set('ft.python.pylama.args', ['--format', 'parsable', '-lpyflakes,mccabe,pylint', '--ignore=D203,D212,D213,D404,D105,I0011,W292'])
     
    if MyOnBattery()
        call neomake#configure#automake('w')
    else
        call neomake#configure#automake('nw', 1000)
    endif
        
endif
