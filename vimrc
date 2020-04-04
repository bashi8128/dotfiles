""" Package control with dein.vim
" Specify directory of dein
let s:dein_path = expand('~/.vim/dein')
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'
" Check whether dein.vim is installed or not
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_path)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_path
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_path, ':p')
endif

if dein#load_state(s:dein_path)
  call dein#begin(s:dein_path)

  let g:config_dir  = expand('~/.vim/dein/userconfig')
  let s:toml        = g:config_dir . '/plugins.toml'
  let s:lazy_toml   = g:config_dir . '/plugins_lazy.toml'

  " Load .toml files
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" Check installation status of plugins and install new plugins
if dein#check_install()
  call dein#install()
endif

" Check toml file and delete removed plugins
let s:plugins_to_remove = dein#check_clean()
if len(s:plugins_to_remove) > 0
  call map(s:plugins_to_remove, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
"""


""" Settings for string search
set incsearch
set ignorecase
set smartcase
set hlsearch

""" Miscellaneous settings
set ambiwidth=double
set autoread	
set backspace=indent,eol,start
set belloff=all
set colorcolumn=80
set cursorline
highlight cursorline term=reverse cterm=none ctermbg=236
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
set nofoldenable
set noswapfile
set number
set shiftwidth=2
set smartindent
set showmatch
set term=xterm-256color 
set wildmenu
set wildmode=full
let &t_SI = "\e]50;CursorShape=1\x7"
let &t_EI = "\e]50;CursorShape=0\x7"
" Enable filetype detection, filetype specific plugin and indent
filetype plugin indent on
" Enable syntax highlighting
syntax on
"""


""" Settings for ALE (Asynchronous Lint Engine)
let g:ale_fixers = {
\  'python': ['autopep8', 'black', 'isort'],
\ }
let g:ale_fix_on_save = 1
let g:python3_host_prog = $PYENV_ROOT . '/versions/vim/bin/python'
let g:ale_python_flake8_executable = g:python3_host_prog
let g:ale_python_flake8_options = '-m flake8'
let g:ale_python_autopep8_executable = g:python3_host_prog
let g:ale_python_autopep8_options = '-m autopep8'
let g:ale_python_isort_executable = g:python3_host_prog
let g:ale_python_isort_options = '-m isort'
let g:ale_python_black_executable = g:python3_host_prog
let g:ale_python_black_options = '-m black'
"""

""" 
"if dein#tap('deoplete.nvim')
"    let g:deoplete#enable_at_startup = 1
"    let g:deoplete#auto_complete_delay = 0
"    let g:deoplete#auto_complete_start_length = 1
"    let g:deoplete#enable_camel_case = 0
"    let g:deoplete#enable_ignore_case = 0
"    let g:deoplete#enable_refresh_always = 0
"    let g:deoplete#enable_smart_case = 1
"    let g:deoplete#file#enable_buffer_path = 1
"    let g:deoplete#max_list = 10000
"endif


""" Use Skeleton for new file
augroup SkeletonAu
autocmd!
autocmd BufNewFile *.html 0r $HOME/.vim/skel.html
autocmd BufNewFile *.c 0r $HOME/.vim/skel.c
autocmd BufNewFile *.css 0r $HOME/.vim/skel.css
autocmd BufNewFile *.scss 0r $HOME/.vim/skel.scss
autocmd BufNewFile *.py 0r $HOME/.vim/skel.py
autocmd BufNewFile *.rb 0r $HOME/.vim/skel.rb
autocmd BufNewFile *.tex 0r $HOME/.vim/skel.tex
augroup END
"""

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

" Call LastModified function when buffer saved.
autocmd BufWritePre * call LastModified()
"""

""" Enable persistent undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif
"""

""" General Settings for key mapping
let mapleader="\<Space>"
""" General Settings for key mapping

""" Key mapping for normal mode
nnoremap j gj
nnoremap k gk
nnoremap J }
nnoremap K {
nnoremap <silent>qq :q<CR>
nnoremap <silent>q1 :q!<CR>
nnoremap <silent>wq :wq<CR>
nnoremap <silent>wqq :wq!<CR>
nnoremap <silent>ww :w<CR>
nnoremap <Leader>w <C-w>w
nnoremap <Leader>l <C-w>l
nnoremap <Leader>h <C-w>h
nnoremap <Leader>k <C-w>k
nnoremap <Leader>j <C-w>j
"""
colorscheme wombat
