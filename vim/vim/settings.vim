" Load individual settings files
for fpath in split(globpath('~/.vim/settings', '*.vim'), '\n')
  exe 'source' fpath
endfor
