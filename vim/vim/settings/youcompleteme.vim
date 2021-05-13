" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_goto_buffer_command = 'new-or-existing-tab'
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1

" Maps
nnoremap <leader>gd :YcmCompleter GoTo<CR>
nnoremap <leader>k :YcmCompleter GetDoc<CR>

" Disable diagnostics for C family languages
let g:ycm_show_diagnostics_ui = 0 

let g:ycm_python_interpreter_path = ''
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \]
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extr_conf.py'



