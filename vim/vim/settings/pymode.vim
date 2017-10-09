" Doc: https://github.com/klen/python-mode 
" Disable if python support not present
if !has('python')
   let g:pymode = 1
endif
" Syntax checking
"let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_checker = "pylint"
let g:pymode_rope=0
let g:pymode_lint=0
" Don't open error window
let g:pymode_lint_cwindow = 0
let g:pymode_lint_message=1
let g:pymode_lint_write=0
let g:pymode_lint_signs=1
map <leader>l :PyLint<CR>
" Load motion
let g:pymode_motion = 1
" Highlight "print" as function
let g:pymode_syntax_print_as_function = 1
" Disable folding
let g:pymode_folding = 0
" No line at 80
let g:pymode_options_max_line_length = 0
