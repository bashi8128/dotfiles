" Specify directory of dein
let s:dein_path = expand('~/.vim/dein')
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'
" Check whether dein.vim is installed or not
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_path)
    execute '!git clone git@github.com:Shougo/dein.vim' s:dein_repo_path
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

" Enable filetype detection, filetype specific plugin and indent
filetype plugin indent on

""" Load vim-ale.vim to configure ALE settings
runtime myautoload/vim-ale.vim

""" Load vim-appearance.vim to configure VIM appearance
runtime myautoload/vim-appearance.vim

""" Load vim-keymap.vim to set up key-map
runtime myautoload/vim-keymap.vim

""" Load vim-option.vim to set basic options
runtime myautoload/vim-option.vim

""" Load vim-skel.vim to configure template for new file
runtime myautoload/vim-skel.vim

" Call LastModified function when buffer saved.
autocmd BufWritePre * call LastModified()
"""

""" Enable persistent undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif
"""

