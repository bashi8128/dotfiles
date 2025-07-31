# setopt
setopt prompt_subst # Allow to use color in the PROMPT (?) 
setopt IGNORE_EOF # Force Shell not to recieve EOF as logout signal.
setopt NO_CLOBBER # Prevent overwrite which occur by redirection.
setopt LIST_PACKED # Display completions in packed.
setopt LIST_ROWS_FIRST # Display completions by row.
setopt AUTO_RESUME # Restart Suspended Process by executing same command.
setopt AUTO_CD # Change directory without cd commmand.
setopt AUTO_PUSHD # pushd automatically when cd command is executed.
setopt PUSHD_IGNORE_DUPS # ignore duplication in direcotry stack.
setopt NO_BEEP # Do not beep

# setting about color
autoload -U colors # Load builtin function named compinit
colors
if [[ -d /opt/local/share/zsh/site-functions ]] then
  fpath=(/opt/local/share/zsh/site-functions $fpath)
fi

bindkey -e

eval $(dircolors)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # Color highight based on colors which can use in gdircolors
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Handle capital letter and small letter in the same manner when completion.
zstyle ':completion:*' menu select=2

# prompt
PROMPT="%(1j|%F{027}|%F{051})bashi%f[%m]%# " # Set Left Prompt Format.
RPROMPT="%{$fg[green]%}[%(5~,~/.../%2~,%~)]%{$reset_color%}" # Set Right Prompt Format.

autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{226}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{196}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd_function1(){
  psvar=()
  vcs_info
  if [[ -n "$vcs_info_msg_0_" ]]
 then
    psvar[1]="$vcs_info_msg_0_"
    if [[ -n “$vcs_info_msg_1_” ]]
    then
      psvar[2]=”$vcs_info_msg_1_”
    elif [[ -n “$vcs_info_msg_2_” ]]
    then
      psvar[2]=”$vcs_info_msg_2_”
    elif [[ -n `echo “$st” | grep “^Untracked”` ]]
    then
      psvar[2]=”Untracked”
    else
      psvar[2]=”Clean”
    fi
  fi
  RPROMPT="%1(v|${vcs_info_msg_0_}|)%{$fg[green]%}[%(5~,~/.../%2~,%~)]%{$reset_color%}" # Set Right Prompt Format.

}
autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_function1

# history
setopt SHARE_HISTORY # Share History between shells.
setopt HIST_IGNORE_ALL_DUPS # Ignore append duplicated command.
setopt EXTENDED_HISTORY #
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zhistory

# alias which can be used at the sentence beginning
alias v='vim' # Set 'v' for neovim
alias vim='nvim' # Set 'v' for neovim
alias jbibtex="pbibtex" #Set 'jbibtex' for pbibtex which allows to manage bibliography
alias grep="grep --color=auto"
alias py="python"
alias jpn="jupyter notebook"
alias igrep="grep -vE '(^$|^\s*#)'"

# Use eza instead of ls if eza exists
if type eza > /dev/null
then
  alias e="eza -g"
  alias ee="e -l --icons=automatic"
  alias ea="e -a --icons=automatic"
  alias ls="e"
  alias ll="ee"
  alias la="ea"
fi

# Shorten the command 'kubectl'
if type kubectl > /dev/null
then
  alias k="kubectl"
fi

# global alias which can be used in the sentence
alias -g G="| grep" # search specific string from result of previous command
alias -g L="| less" # preview result of previous command in the less term
alias -g Be="| base64 -e" # encode strings with base64 encoding
alias -g Bd="| base64 -d" # Decode strings encoded with base64 encoding

if type yq > /dev/null
then
  alias -g Y="| yq" # Decode strings encoded with base64 encoding
fi

if type jq > /dev/null
then
  alias -g J="| jq" # Decode strings encoded with base64 encoding
fi

# Set mkubectl if minikube is installed
if type minikube > /dev/null
then
  alias mkubectl="minikube kubectl --"
fi

# misc
DIRSTACKSIZE=10
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export LESSOPEN='|lesspipe.sh %s'
export LESS='--RAW-CONTROL-CHARS'

autoload history-search-end
zle -N history-beginning-search-forward-end history-search-end
zle -N history-beginning-search-backward-end history-search-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^P" history-beginning-search-backward-end

# function
function delete(){sudo mv $@ ~/.trash}

function google() {
    local search_string
    for i
    do search_string="$search_string+$i"
    done
    open http://www.google.co.jp/search\?q=$search_string\&hl=jaf
}

# ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # gitで管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全てcommitされてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # gitに管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git addされていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commitされていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合は青色で表示させる
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}


ffmp4-speedup-filter () {
  readonly local speed=$1
  local v="[0:v]setpts=PTS/${speed}[v]"
  if [ $speed -le 2 ]; then
    local a="[0:a]atempo=${speed}[a]"
  elif [ $speed -le 4 ]; then
    local a="[0:a]atempo=2,atempo=$speed/2[a]"
  elif [ $speed -le 8 ]; then
    local a="[0:a]atempo=2,atempo=2,atempo=$speed/4[a]"
  fi
  noglob echo -filter_complex "$v;$a" -map [v] -map [a]
}

ffmp4-speedup () {
  if [ $# -lt 2 ]; then
    echo "Usage: $0 file speed"
    echo "Convert movie(file) to nx playback mp4 file."
    echo "(ex.) $0 input.mov 2"
    echo "      will generate 2x playback mp4 file (input_x2.mp4)"
    return
  fi
  red=`tput setaf 1; tput bold`
  green=`tput setaf 2; tput bold`
  reset=`tput sgr0`
  readonly local src=$1
  readonly local speed=$2
  dst=${src:r}_x${speed}.mp4
  readonly local config="-crf 23 -c:a aac -ar 44100 -b:a 64k -c:v libx264 -qcomp 0.9 -preset slow -tune film -threads auto -strict -2"
  readonly local args="-v 0 -i $src $config $(ffmp4-speedup-filter $speed) $dst"
  echo -n "Converting $src to ${speed}x playback as $dst ... "
  ffmpeg `echo $args`
  if [[ $? = 0 ]]; then
    echo "${green}OK${reset}"
  else
    echo "${red}Failed${reset}"
  fi
}

ffinfo() {
while [[ "$1" != "" && -f $1 ]];
do
  echo "$1"
  ffmpeg -i $1 |& grep Stream
  shift
done
}

chkvid() {
while [[ "$1" != "" && -f $1 ]];
do
  array=(`ffinfo $1 | grep Video | perl -lane 'print $1 if /(\d{2,}x\d+)/' | awk -F"x" '{ print $1" "$2 }'`)
  if [[ $(($array[1] % 2)) == 1 || $(($array[2] %2)) == 1 ]]; then
    echo "NG: $array[1] x $array[2] : $1"
  else
    echo "OK: $array[1] x $array[2]"
  fi
  shift
done
}

ffmp4 () {
if [ "$1" = "" ]; then
  echo "$0 filename [file ...]"
  echo "  will create filename.mp4 file"
  return
fi
red=`tput setaf 1; tput bold`
green=`tput setaf 2; tput bold`
blue=`tput setaf 4; tput bold`
cyan=`tput setaf 6; tput bold`
reset=`tput sgr0`
while [[ "$1" != "" && -f $1 ]];
do
  out=$1:r.mp4
  if [[ ${out} = $1 ]]; then
    echo "Can't convert $1 to $out ($1 is already mp4 file). "
  else
    echo -n "Converting $1 to $out ... "
    isok=`chkvid $1 | awk -F":" '{print $1}'`
    if [[ "$isok" = "OK" ]]; then
      ffmpeg -threads 4 -v 0 -i $1 -q:a 0 -q:v 0 -strict -2 $out
      #ffmpeg -threads 4 -v 0 -i $1 -an -q:v 0 -strict -2 $out  # no audio
    else
      ffmpeg -threads 4 -v 0 -i $1 -q:a 0 -q:v 0 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -strict -2 $out
      #ffmpeg -threads 4 -v 0 -i $1 -an -q:v 0 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -strict -2 $out # no audio
    fi
    if [[ $? = 0 ]]; then
      echo "${green}OK${reset}"
    else
      echo "${red}Failed${reset}"
    fi
  fi
  shift
done
}

# git diff with bat command
function bdiff() {
  git diff --name-only --diff-filter=d 2> /dev/null | xargs bat --diff
}

fpath=($fpath ~/.zfunc)
autoload -Uz compinit && compinit

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export EDITOR=nvim
export GPG_TTY=$(tty)

# Settings for .dotfiles manged in bare Git repository
export DOTFILES_DIR="${HOME}/.dotfiles"
alias config='/usr/bin/git --git-dir="${DOTFILES_DIR}" --work-tree="${HOME}"'
