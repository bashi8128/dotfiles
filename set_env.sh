#!/bin/sh

# Recognize OS
UNAME_RES=`uname -a`
if [[ $UNAME_RES =~ "FreeBSD" ]]; then
  OS="FreeBSD"
elif [[ $UNAME_RES =~ "Darwin" ]]; then
  OS="Darwin"
elif [[ $UNAME_RES =~ "Linux" ]]; then
  OS_RELEASE=`cat /etc/os-release`
  if [[ $OS_RELEASE  =~ "CentOS" ]]; then
    OS="CentOS"
  elif [[ $OS_RELEASE =~ "Ubuntu" ]]; then
    OS="Ubuntu"
  fi
fi

if [[ $OS = "" ]]; then
  echo "Not supported OS."
  echo "This script supports Darwin, FreeBSD, CentOS or Ubuntu."
  exit 1
fi

repo_path=$(pwd)

# Set up pyenv
if [[ ! -d ~/.pyenv ]]; then
  git clone https://github.com/yyuu/pyenv.git ~/.pyenv
fi

# Set up latest tmux
if [[ ! -d ~/git/tmux ]]; then
  if [[ $OS = "CentOS" ]]; then
    yum -y groupinstall "Development Tools"
    yum -y install libevent-devel ncurses-devel
  elif [[ $OS = "Ubuntu" ]]; then
    apt-get install git automake bison build-essential pkg-config libevent-dev libncurses5-dev
  elif [[ $OS = "FreeBSD" ]]; then
    pkg install libevent ncurses automake aclocal
  else
    port install libevent nucrses automake aclocal
  fi
  
  git clone https://github.com/tmux/tmux ~/git/tmux
  cd ~/git/tmux
  ./autogen.sh
  ./configure --prefix=/usr/local
  make
  make insall
fi

# Create symblic link if needed
if [[ ! -e $HOME/bin ]];then
    ln -s $repo_path/bin $HOME/bin
fi

if [[ ! -e $HOME/.tmux.conf ]]; then
    ln -s $repo_path/tmux.conf $HOME/.tmux.conf
fi

if [[ ! -e $HOME/.vimrc ]]; then
  ln -s $repo_path/vimrc $HOME/.vimrc
fi

echo 'path=( $path $HOME/bin )' >> $HOME/.zshenv
