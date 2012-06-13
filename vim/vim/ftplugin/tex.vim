setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
if filereadable('Makefile')
  setlocal makeprg=make
else
  setlocal makeprg=latexmk
endif
"Turn on spelling
"setlocal spell spelllang=en_us

" Expansions
imap <buffer> [[ \begin{
imap <buffer> ]] <plug>LatexCloseLastEnv
nmap <buffer> <f5> <plug>LatexChangeEnv
vmap <buffer> <f7> <plug>LatexWrapSelection
vmap <buffer> <s-f7> <plug>LatexWrapSelectionEnv
