export GOPATH=$HOME/go

export path=( ${HOME}/.local/bin ${HOME}/bin ${KREW_ROOT:-$HOME/.krew}/bin /usr/share/bcc/tools/ ${path} )

# Update PATH for the bin directory used by cargo
source "$HOME/.cargo/env"

# Activate mise
eval "$(~/.cargo/bin/mise activate zsh)"

# Update PATH for the Google Cloud SDK.
if [ -f '/home/itabashi/.bin/google-cloud-sdk/path.zsh.inc' ]; then . '/home/itabashi/.bin/google-cloud-sdk/path.zsh.inc'; fi

# Enable shell command completion for gcloud.
if [ -f '/home/itabashi/.bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/itabashi/.bin/google-cloud-sdk/completion.zsh.inc'; fi

# Use atuin
eval "$(atuin init zsh)"
