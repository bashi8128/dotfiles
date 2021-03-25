""" Setting for skelton files
augroup SkeletonAu
autocmd!
autocmd BufNewFile *.html 0r $HOME/.vim/skel.html
autocmd BufNewFile *.c 0r $HOME/.vim/skel.c
autocmd BufNewFile *.rs 0r $HOME/.vim/skel.rs
autocmd BufNewFile *.css 0r $HOME/.vim/skel.css
autocmd BufNewFile *.scss 0r $HOME/.vim/skel.scss
autocmd BufNewFile *.py 0r $HOME/.vim/skel.py
autocmd BufNewFile *.rb 0r $HOME/.vim/skel.rb
autocmd BufNewFile *.tex 0r $HOME/.vim/skel.tex
augroup END

""" Enable auto timestamp
" Function for inserting timestamp after 'Last modified: '
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([40, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Last modified: \).*#\1' .
          \ strftime('%a, %d %b %Y %H:%M:%S %z') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
  endfun
