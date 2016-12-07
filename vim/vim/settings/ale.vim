let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:ale_lint_on_enter = 0
let g:ale_linter_aliases = {'pandoc': 'markdown'}
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_python_flake8_args = '--max-line-length=100'