" Open the current document in MacDown.app
setl tabstop=2
setl softtabstop=2
setl makeprg=pandoc\ \"%\"\ -o\ \"%:r.pdf\"\ \&\&\ open\ \"%:r.pdf\"
command! Ql silent !qlmanage -p "%" &> /dev/null
