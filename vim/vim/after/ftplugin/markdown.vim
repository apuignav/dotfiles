" Open the current document in MacDown.app
set tabstop=2
set softtabstop=2
set makeprg=pandoc\ \"%\"\ -o\ \"%:r.pdf\"\ \&\&\ open\ \"%:r.pdf\"
