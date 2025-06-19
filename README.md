# dotfiles

My dotfiles

## How to setup

I’m using a bare git repository so I don’t have to use symbolic links.  
You can deploy the dotfiles into your home directory using the following command.  

```bash
export DOTFILES_DIR="${HOME}/.dotfiles"

git clone --bare https://github.com/bashi8128/dotfiles.git "${DOTFILES_DIR}"

alias config='/usr/bin/git --git-dir="${DOTFILES_DIR}" --work-tree="${HOME}"'
config config status.showUntrackedFiles no
config checkout
```

> [!CAUTION]
> If there are already managed files in your home directory,  
> `config checkout` may fail. In that case, please back up the existing  
> files and run the `config checkout` again.
