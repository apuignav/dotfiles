setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
if filereadable('Makefile')
  setlocal makeprg=make
else
  exec "setlocal makeprg=make\\ -f\\ ~/.latex.mk\\ " . substitute(bufname("%"),"tex$","pdf", "")
endif
"Turn on spelling
setlocal spell spelllang=en_us
