" Config
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\|^\.DS_Store\',
  \ }
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif
" Default to filename searches - so that appctrl will find application
" controller
let g:ctrlp_by_filename = 1
" Don't jump to already open window. This is annoying if you are maintaining
" several Tab workspaces and want to open two windows into the same file.
let g:ctrlp_switch_buffer = 0
"
let g:ctrlp_working_path_mode = 0
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_max_height = 20

" Keybinding
map <c-b> :CtrlPBuffer<cr>
let g:ctrlp_map = '<c-f>'
nnoremap <silent> <c-f> :CtrlP<CR>
