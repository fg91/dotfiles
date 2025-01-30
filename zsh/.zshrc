export PATH="$PATH:/opt/homebrew/bin"


alias k=kubectl
alias wk="watch kubectl"
alias kp="watch kubectl get pod"

source <(kubectl completion zsh)

export EDITOR=emacs

. "$HOME/.cargo/env"

#source $HOME/.cargo/envexport
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
