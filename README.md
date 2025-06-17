# dotfiles

My dotfiles

## How to setup

```
export DOTFILES_DIR="${HOME}/.dotfiles"

git clone --bare https://github.com/bashi8128/dotfiles.git "${DOTFILES_DIR}"

alias config='/usr/bin/git --git-dir="${DOTFILES_DIR}" --work-tree="${HOME}"'
config config status.showUntrackedFiles no
config checkout
```
