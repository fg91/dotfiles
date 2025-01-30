autoload -Uz compinit && compinit

export PATH="$PATH:/opt/homebrew/bin"

# zsh config
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


alias k=kubectl
alias wk="watch kubectl"
alias kp="watch kubectl get pod"

source <(kubectl completion zsh)
source <(fzf --zsh)


export EDITOR=emacs

. "$HOME/.cargo/env"

#source $HOME/.cargo/envexport
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

eval "$(starship init zsh)"
