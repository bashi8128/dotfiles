#!/bin/sh

repo_path=$(pwd)

if [ ! -e $HOME/bin ];then
    ln -s $HOME/bin $repo_path/bin
fi

if [ ! -e $HOME/.tmux.conf ]; then
    ln -s $HOME/.tmux.conf $repo_path/tmux.conf
fi

echo 'path=( $path $HOME/bin )' >> $HOME/.zshrc
