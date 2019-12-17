#!/bin/sh

repo_path=$(pwd)

if [ ! -e $HOME/bin ];then
    ln -s $repo_path/bin $HOME/bin
fi

if [ ! -e $HOME/.tmux.conf ]; then
    ln -s $repo_path/tmux.conf $HOME/.tmux.conf
fi

echo 'path=( $path $HOME/bin )' >> $HOME/.zshenv
