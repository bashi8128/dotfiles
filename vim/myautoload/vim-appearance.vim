set runtimepath+=~/.config/nvim/dein/repos/github.com/sheerun/vim-wombat-scheme/

""" Settings for vim-airline
let g:airline_theme = 'wombat'
let g:airline#extensions#branch#enabled = 1


""" Global colorscheme
colorscheme wombat

let &t_SI = "\e]50;CursorShape=1\x7"
let &t_EI = "\e]50;CursorShape=0\x7"

" Enable syntax highlighting
syntax on
