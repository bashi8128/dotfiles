if g:dein#_cache_version !=# 100 || g:dein#_init_runtimepath !=# '/Users/itabashi/.vim/dein/repos/github.com/Shougo/dein.vim/,/Users/itabashi/.vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim82,/usr/local/share/vim/vimfiles/after,/Users/itabashi/.vim/after' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/itabashi/.vimrc', '/Users/itabashi/.vim/dein/userconfig/plugins.toml', '/Users/itabashi/.vim/dein/userconfig/plugins_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/itabashi/.vim/dein'
let g:dein#_runtime_path = '/Users/itabashi/.vim/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/Users/itabashi/.vim/dein/.cache/.vimrc'
let &runtimepath = '/Users/itabashi/.vim/dein/repos/github.com/Shougo/dein.vim/,/Users/itabashi/.vim,/usr/local/share/vim/vimfiles,/Users/itabashi/.vim/dein/repos/github.com/Shougo/dein.vim,/Users/itabashi/.vim/dein/.cache/.vimrc/.dein,/usr/local/share/vim/vim82,/Users/itabashi/.vim/dein/.cache/.vimrc/.dein/after,/usr/local/share/vim/vimfiles/after,/Users/itabashi/.vim/after'
